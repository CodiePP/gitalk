#!/usr/bin/env bash

if [ ! $# -eq 1 ]; then
	echo "Usage: $0 <input file>"
	exit 1
fi

INSTPATH=`dirname $0`
. ${INSTPATH}/colors.sh

HEADER=$1
if [ ! -e ${HEADER} ]; then
	#echo "cannot find header file: ${HEADER}"
	exit 1
fi

UNAME=$(uname -s)
SED=sed
if [ $UNAME = "Darwin" ]; then
  SED=${SED:-gsed}
fi

if [ -z "${HTML2TEXT}" ]; then
        echo "don't know html2text!"
        HTML2TEXT=html2text
elif [ ! -e ${HTML2TEXT} ]; then
        echo "unknown html2text: ${HTML2TEXT}!"
        HTML2TEXT=html2text
fi
if [ ! -e ${HTML2TEXT} ]; then
        echo "unknown html2text: ${HTML2TEXT}!"
        exit 1
fi

BASENM=`basename ${HEADER} .md`

if [ ${BASENM} -nt ${HEADER} ]; then
	prtLightGray "no new update to file ${BASENM}"; echo
	exit 1
fi

if [ -e ${BASENM}_t ]; then
	rm ${BASENM}_t
fi

# test for <fpaste > 
patpaste='<fpaste '
nl -ba ${HEADER} | {
	read n l
	echo "\\#line $n \"${HEADER}\""
	echo
	while [ -n "$n" ]; do
		if [[ $l =~ $patpaste ]]; then
			FN=`echo "$l" | $SED -ne 's/[<]fpaste[ ]*\(.*\)[>].*/\1/p'`
                        if [ -f "$FN" ]; then
				echo "#line 1 \"${FN}\""
				cat "$FN"
				echo "\\#line $((n+1)) \"${HEADER}\""
				echo
			else
				echo "// missing file: ${FN}"
				echo
			fi
		else
			echo "$l"
		fi
		read n l
	done
} >> ${BASENM}_t

pandoc -f markdown -t html --ascii ${BASENM}_t -o ${BASENM}.html

$SED -i -e 's/&#822[01];/"/g;s/&#x201[CD];/"/g;' ${BASENM}.html

if [ ! -e ${BASENM} ]; then
  touch ${BASENM}
fi

${HTML2TEXT} -nobs -to_encoding ASCII -width 232 -o ${BASENM} ${BASENM}.html

# replace some annoying characters
$SED -i -e 's/&#822[01];/"/g;s/&#x201[CD];/"/g;' ${BASENM}
$SED -i -e 's/^\*\*\*\*\*\* //;' ${BASENM}
$SED -i -e 's/^\*\*\*\*\* //;' ${BASENM}
$SED -i -e 's/ \*\*\*\*\*\*$//;' ${BASENM}
$SED -i -e 's/ \*\*\*\*\*$//;' ${BASENM}

if [ -e ${BASENM}_t ]; then
	rm ${BASENM}_t
fi
if [ -e ${BASENM}-e ]; then
	rm ${BASENM}-e
fi
if [ -e ${BASENM}.html ]; then
	rm ${BASENM}.html
fi
if [ -e ${BASENM}.html-e ]; then
	rm ${BASENM}.html-e
fi

