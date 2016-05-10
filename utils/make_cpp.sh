#!/bin/bash

# this script scans a header page
# and for every .cpp.page found
# it extracts the C++ code
# and puts it in a source file .cpp
# with the same name as the header file

if [ ! $# -eq 1 ]; then
	echo "Usage: $0 <header page>"
	exit 1
fi

INSTPATH=`dirname $0`

HEADER=$1
INDIR=`dirname ${HEADER}`

if [ ! -e ${HEADER} ]; then
	echo "cannot find header file: ${HEADER}"
	exit 1
fi

ALPHASRC=${INDIR}/`basename ${HEADER} .hpp.md`_-alpha-.md
OMEGASRC=${INDIR}/`basename ${HEADER} .hpp.md`_-omega-.md
CPPSRC=`basename ${HEADER} .hpp.md`.cpp

if [ -e ${CPPSRC} ]; then
	# code fragments
	for F in `bash -c ${INSTPATH}/find_cpp.sh ${HEADER} | sort | uniq`; do 
		if [ ${F} -nt ${CPPSRC} ]; then
			rm -v ${CPPSRC}
			break
		fi
	done
	if [ -e ${CPPSRC} -a ${CPPSRC} -nt ${ALPHASRC} -a ${CPPSRC} -nt ${OMEGASRC} -a ${CPPSRC} -nt ${HEADER} ]; then
		echo "output c++ source file still consistent! ${CPPSRC}"
		exit 1
	fi
	rm -v ${CPPSRC}
fi

# header
if [ -e ${ALPHASRC} ]; then
	echo "header ${ALPHASRC}"
	#echo "// parsed from source file ${ALPHASRC}" >> ${CPPSRC}
	bash -c ${INSTPATH}/extract_cpp.sh ${ALPHASRC} >> ${CPPSRC}
fi

# code fragments
for F in `bash -c ${INSTPATH}/find_cpp.sh ${HEADER} | sort | uniq`; do 
	echo "parsing c++ in ${F}"
	#echo "// parsed from source file $F" >> ${CPPSRC}
	bash -c ${INSTPATH}/extract_cpp.sh $F >> ${CPPSRC} 
done

# trailer
if [ -e ${OMEGASRC} ]; then
	echo "trailer ${OMEGASRC}"
	#echo "// parsed from source file ${OMEGASRC}" >> ${CPPSRC}
	bash -c ${INSTPATH}/extract_cpp.sh ${OMEGASRC} >> ${CPPSRC}
fi

