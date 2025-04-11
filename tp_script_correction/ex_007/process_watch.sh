#!/bin/bash

sn=$(basename $0)
usage="Usage: '$sn'"

if [[ $# -lt 1 || $# -gt 2 ]] ; then
    echo "$usage PROCESSNAME [INTERVAL]"
    exit 1
fi

process_name=$1
interval=${2:-300}

while : ; do 
    processes=$( ps u -C "$process_name" )

    nb_lines=$( echo "$processes" | wc -l )
    if [[ $nb_lines -gt 1 ]] ; then
        echo "$processes" | awk '{print $2 "\t" $1 "\t" $4 "\t" $3 "\t" $11}'
    else
        echo "WARNING! '$process_name' is not running."
    fi
    echo
    sleep $interval
done