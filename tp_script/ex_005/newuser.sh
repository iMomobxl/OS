#!/bin/bash

sn=$(basename $0)

# check if root
if [[ $EUID -ne 0 ]] ; then
    echo "$sn: Vous devez etre root"
    exit 1
fi

# check le nombre de parametre (min 1 - max 3)
if [[ $# -lt 1 || $# -gt 3 ]] ; then
    echo "Usage: $sn USERNAME [PASSWORD] [SHELL]"
    exit 2
fi

username=$1
# check if the user exist
getent passwd $username &>/dev/null 

# getent return 0 if user exist, 1 if user not exist

if [[ $? -eq 0 ]] ; then
    echo "L'utilisateur existe déjà"
    exit 3
fi

# check du parametre password
if [[ -z $2 ]] ; then
    password=password
else
    password=$2
fi

echo "password: $password"

# check du parametre bin
if [[ -z $3 ]] ; then
    shell=/bin/bash
else   
    shell=$3
fi

echo "shell: $shell"