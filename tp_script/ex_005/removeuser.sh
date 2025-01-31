#!/bin/bash

sn=$(basename $0)

# check if root
if [[ $EUID -ne 0 ]] ; then
    echo "$sn: Vous devez etre root"
    exit 1
fi

# check le nombre de parametre (min/max 1)
if [[ $# -ne 1 ]] ; then
    echo "Usage: $sn USERNAME"
    exit 2
fi

username=$1

# check if the parameter is a user
getent passwd $username &>/dev/null # getent return 0 if user exist, 1 if user not exist

if [[ $? -ne 0 ]] ; then
    echo "$sn: L'utilisateur '$username' n'existe pas"
    exit 3
fi

userdel -r -f $username &>/dev/bull

exit 0