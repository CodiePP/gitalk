#!/bin/bash

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
			FN=`echo "$l" | sed -ne 's/[<]fpaste[ ]*\(.*\)[>].*/\1/p'`
                        if [ -f "$FN" ]; then
				echo "#line 1 ${FN}"
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

html2text -nobs -ascii -width 132 -style pretty -o ${BASENM} ${BASENM}.html

if [ -e ${BASENM}_t ]; then
	rm ${BASENM}_t
fi
if [ -e ${BASENM}.html ]; then
	rm ${BASENM}.html
fi

