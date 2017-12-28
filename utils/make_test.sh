#!/bin/bash

# this script scans a header page
# and for every .cpp.md found
# it extracts the C++ code
# and puts it in a source file .cpp

if [ ! $# -eq 1 ]; then
	echo "Usage: $0 <header page>"
	exit 1
fi

INSTPATH=`dirname $0`
. ${INSTPATH}/colors.sh

HEADER=$1
INDIR=`dirname ${HEADER}`

if [ ! -e ${HEADER} ]; then
	#echo "cannot find header file: ${HEADER}"
	exit 1
fi

# code fragments
for F in `bash ${INSTPATH}/find_cpp.sh ${HEADER}`; do 
	CPPSRC=`basename ${F} .md`
	if [ ! -e $CPPSRC -o $F -nt $CPPSRC ]; then
		echo -n "parsing c++ in "; prtBrown ${F}; echo
		bash ${INSTPATH}/extract_cpp.sh $F > ${CPPSRC} 
	else
		prtLightGray "no change in ${F}"; echo
	fi
done

