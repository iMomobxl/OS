#!/bin/bash

sn=$(basename $0)
usage="Usage: '$sn'"

if [[ $EUID -ne 0 ]] ; then
    echo "vous devez etre root"
    exit 1
fi

dir=/web

if [[ -d "$dir" ]] ; then
    echo "le repertoire '$dir' existe deja"
    exit 2
fi

mkdir "$dir"

if [[ ! -d "$dir" ]] ; then
    echo "erreur lors de la creation de '$dir' car n'est pas un repertoire"
    exit 3
fi

chmod 751 /web

# root est "normalement" deja proprietaire"
chown root:root /web

