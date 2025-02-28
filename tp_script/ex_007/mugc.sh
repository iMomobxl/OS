#!/bin/bash

# check nombre parametre
sn=$(basename $0)
usage="Usage: '$sn'"

if [[ $# -lt 1 ]] ; then
    echo "$usage PATH [COMPILATION_OPTIONS]"
    exit 1
fi

path=$1

# check si path est un repertoire valide
if [[ ! -d "$path" ]] ; then
    echo "'$path' n'est pas un repertoire valide"
    exit 2
fi

time=$(( 5 + RANDOM % 11 ))

echo -n "Compiling '$path'..."

sleep $time

random_nbr=$(( 1 + RANDOM % 8 ))
#random_nbr=1

case $random_nbr in
    1) 
        echo "FAILED!"
        exit 3
        ;;
    *)
        echo "done."
        ;;
esac