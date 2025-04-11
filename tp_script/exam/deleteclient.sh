#!/bin/bash

sn=$(basename $0)
usage="Usage: '$sn'"

if [[ $EUID -ne 0 ]] ; then
    echo "vous devez etre root"
    exit 1
fi

if [[ $# -ne 1 ]] ; then
    echo "$usage USERNAME"
    exit 2
fi

username=$1

getent passwd $username &>/dev/null 

if [[ $? -ne 0 ]] ; then
    echo "$sn: L'utilisateur '$username' n'existe pas"
    exit 3
fi

userdel -r -f $username &>/dev/bull

if [[ ! -d "/web/$username" ]] ; then
   echo "le repertoire '/web/$username' n'existe pas"
   exit 4
fi

rm -rf /web/$username

if [[ $? -ne 0 ]] ; then
    echo "erreur lors la suppression de '/web/$username'"
    exit 5
fi