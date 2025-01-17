#!/bin/bash

#######################
######## ex_999 #######
# etoilenoir.sh script 
#######################

sn=$(basename $0)

# check root
if [[ $EUID -ne 0 ]] ; then
    echo "You must be root to access all the file."
    exit 1;
fi

# check number parametre
if [[ $# -ne 1 ]] ; then
    echo "Usage: $sn: Must have only 1 parameters"
    exit 2
fi

param=$1

# check if the param is directory
if [[ ! -d $param ]] ; then
    echo "$param is not a directory"
    exit 3
fi

counter_file=0
taille_global=0

# function recursive
check_directory() {
    for elem in "$1"/* "$1/.*" ; do 
        if [[ -d "$elem" ]]; then 
            check_directory "$elem" 
        elif [[ -f "$elem" ]]; then 
            counter_file=$((counter_file + 1)) 
            taille=$(stat --format=%s $elem) 
            taille_global=$((taille_global + taille)) 
        fi 
    done
}

check_directory $param

# check analyse
if [[ $? -ne 0 ]] ; then
    echo "Error: check_directory didn't work"
    exit 4
fi

echo "Nombre de fichier: $counter_file"
echo "Tailel global des fichier: $taille_global octets"