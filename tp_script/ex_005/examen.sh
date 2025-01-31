#!/bin/bash

sn=$(basename $0)

# check if root
if [[ $EUID -ne 0 ]] ; then
    echo "$sn: Vous devez etre root"
    exit 1
fi

usage="Usaage: '$sn'"

# check si 1 parametre
if [[ $# -ne 1 ]] ; then
    echo "$usage [USERNAME]"
    exit 2
fi

mkdir /examen

# check si l'utilisateur existe
username=$1

getent passwd $username &>/dev/null

if [[ $? -ne 1 ]] ; then
    echo "l'utilisateur n'existe pas"
    ./newuser $username