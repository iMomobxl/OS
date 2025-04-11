#!/bin/bash

sn=$(basename $0)
if [[ $# -lt 1 ]] ; then
    echo "Usage: $sn PATH [OPTION]"
    exit 1
fi

if [[ ! -d "$1" ]] ; then
    echo "$sn: '$1' n'est pas un repertoire." 
    exit 2
fi

echo -n "Compiling '$1'..."

sleep_time=$(($RANDOM % 11 + 5))

sleep $sleep_time

r=$(($RANDOM % 8))

if [[ $r -eq 0 ]] ; then
    echo "FAILED!"
    exit 3
else 
    echo " done."
fi
