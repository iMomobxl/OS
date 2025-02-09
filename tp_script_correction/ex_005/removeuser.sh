#!/bin/bash

sn=$(basename $0)

if [[ $EUID -ne 0 ]] ; then
    echo "Il faut etre root"
    exit 1
fi

if [[ $# -ne 1 ]] ; then
    echo "Usage: $sn NOMUTILISATEUR"
    exit 2
fi


user_to_delete=$1

id $user_to_delete > /dev/null 2>&1

if [[ $? -eq 0 ]] ; then
    echo "$sn: '$username' n'existe pas"
    exit 3
fi
