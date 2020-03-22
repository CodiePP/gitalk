#!/usr/bin/env bash

# this script extracts blocks between 
# ~~~ cpp
# and
# ~~~
# and writes them to stdout
#
# also recognises:  ~~~c++

if [ ! $# -eq 1 ]; then
	echo "Usage: $0 <input file>"
	exit 1
fi

SRC=$1
if [ ! -e ${SRC} ]; then
	#echo "file ${SRC} not found!"
	exit 1
fi

#patstart='[~]{3}[ ]*[{][ ]*[.][Cc][Pp][Pp][ ]*[}]'
patstart='[`]{3}[Cc][\+Pp][\+Pp]'
#patend='[~]{3}'
patend='[`]{3}'
patpaste='<fpaste '
nl -ba ${SRC} | {
	read n l
	while [ -n "${n}" ]; do
		if [[ "$l" =~ $patpaste ]]; then
			FN=`echo $l | sed -ne 's/[<]fpaste[ ]*\(.*\)[>].*/\1/p'`
			if [ -f "$FN" ]; then
				echo "#line 1 ${FN}"
				cat "$FN"
			else
				echo "// missing file: ${FN}"
			fi

		elif [[ "$l" =~ $patstart ]]; then
			echo "#line $((n+1)) \"${SRC}\""
			read n l
			while [ -n "${n}" ]; do
				if [[ "$l" =~ $patend ]]; then
					break
				else	
					echo "$l"
					read n l
				fi
			done

		#else
			#echo
		fi

		read n l
	done
}


#sed -ne '
# match .cpp
#/^[~][~][~].*[.][Cc][Pp][Pp]/ b more
#b fin
#
#:more
#n
## match three tildes
#/^[~][~][~]/ b fin
#
#p
#
#b more
#
#:fin
#' ${SRC}

fpaste=`egrep '^<fpaste \(.*\)>' ${SRC}`

