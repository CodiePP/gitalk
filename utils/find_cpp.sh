#!/bin/sh

# this script scans the input file
# for occurences of .cpp.md
# and outputs their full path

DIRN=`dirname $1`

# match .cpp
for FN in `sed -ne 's/.*\](\(.*\.cpp\).*/\1.md/p;' $1`; do
	echo "${DIRN}/${FN}"
done

