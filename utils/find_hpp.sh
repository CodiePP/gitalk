#!/bin/sh

# this script scans the input file
# for occurences of .hpp.md
# and outputs their full path

DIRN=`dirname $1`

# match .hpp
for FN in `sed -ne 's/.*\](\(.*\.hpp\).*/\1.md/p;' $1 | sort | uniq`; do
	FN=`basename ${FN}`
	echo "${DIRN}/${FN}"
done

