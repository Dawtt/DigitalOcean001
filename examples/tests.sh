#!/usr/bin/env bash

#seq=(1,2,3,4,5,6,7,8,9,10)

s="Here is a String"
#
#echo ${s} | sed 's/[^ _-]*/\\&/g'
#
#
#echo ${s} | awk '{print $0 tolower(substr($0,length($0)-1,2))}'
#
#
#echo ${s} | awk '{print substr($0,1,length($0)-2) tolower(substr($0,length($0)-1,2))}'


#IFS="" # this sets the for loop delimiter. default is space?
#
#for i in ${s}; do
#    echo $i
#done
#
#for i in ${s}; do
#    echo ${s:$i:1}
#done

SPACE_ADVANCE=0                                     # Incremented on spaces, to ignore spaces in pattern output
for (( i=0; i<${#s}; i++ )); do
    if [[ "${s:$i:1}" =~ \ |\  ]]; then             # this only identifies a space with regex
        (( SPACE_ADVANCE++ ))                       # increment if there's a space.
    fi

if !(( ( i + SPACE_ADVANCE ) % 2 )); then           # alternates upper & lower case
        printf "${s:$i:1}" | tr '[:upper:]' '[:lower:]'
    else
        printf "${s:$i:1}" | tr '[:lower:]' '[:upper:]'
    fi
done

