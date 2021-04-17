#!/usr/bin/env bash

if [ ! $# -eq 1 ]; then
	echo "Usage: $0 <input file>"
	exit 1
fi

INSTPATH=`dirname $0`
. ${INSTPATH}/colors.sh

INFILE=$1
if [ ! -e ${INFILE} ]; then
	echo "cannot find header file: ${INFILE}"
	exit 1
fi

for HPP in `bash ${INSTPATH}/find_hpp.sh ${INFILE}`; do
  bash ${INSTPATH}/make_cpp.sh ${HPP}
done

exit 0