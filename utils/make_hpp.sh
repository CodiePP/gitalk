#!/bin/sh

if [ ! $# -eq 1 ]; then
	echo "Usage: $0 <input file>"
	exit 1
fi

HEADER=$1
if [ ! -e ${HEADER} ]; then
	echo "cannot find header file: ${HEADER}"
	exit 1
fi

BASENM=`basename ${HEADER} .md`

if [ ${BASENM} -nt ${HEADER} ]; then
	echo "no new update to file ${BASENAME}" 
	exit 1
fi


pandoc -f markdown -t html --ascii --self-contained ${HEADER} -o ${BASENM}.html

html2text -nobs -ascii -width 132 -style pretty -o ${BASENM} ${BASENM}.html

if [ -e ${BASENM}.html ]; then
	rm -v ${BASENM}.html
fi
