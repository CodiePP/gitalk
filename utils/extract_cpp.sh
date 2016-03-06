#!/bin/sh

# this script extracts blocks between 
# ~~~ { .cpp }
# and
# ~~~
# and writes them to stdout
#

if [ ! $# -eq 1 ]; then
	echo "Usage: $0 <input file>"
	exit 1
fi

TGT=$1
if [ ! -e ${TGT} ]; then
	#echo "file ${TGT} not found!"
	exit 1
fi

sed -ne '
# match .cpp
/^[~][~][~].*[.][Cc][Pp][Pp]/ b more
b fin

:more
n
# match three tildes
/^[~][~][~]/ b fin

p

b more

:fin
' ${TGT}

