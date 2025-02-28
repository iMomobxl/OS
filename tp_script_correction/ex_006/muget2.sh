#!/bin/bash

sn=$(basename $0)

if [[ $# -lt 1 || $# -gt 2 ]] ; then
    echo "Usage: '$sn' URL [FILENAME]"
    exit 1
fi

url=$1
script_name=$2

if [[ -z "$script_name" ]] ; then
    script_name=$(basename "$url")
fi

# simuler un temps de telechargement 2 a 5sec
sleep $(( $RANDOM % 4 + 2 ))

random_value=$(( $RANDOM % 16 ))
#random_value=0
#random_value=1

if [[ $random_value -eq 0 ]] ; then
    echo "$sn: impossible de telecharger"
    exit 2
elif [[ $random_value -eq 1 ]] ; then
    echo "$sn: erreur pendant le telechargement de '$url'"
    echo '#/bin/bash' > "$script_name"
    echo >> "$script_name"
    echo 'echo "Je suis un fichier corrompu"' >> "$script_name"
    exit 3
else
    echo '#/bin/bash' > "$script_name"
    echo >> "$script_name"
    echo 'echo "Je suis "$script_name""' >> "$script_name"
fi

