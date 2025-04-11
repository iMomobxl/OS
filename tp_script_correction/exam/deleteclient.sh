#!/bin/bash

sn=$(basename $0)
usage="Usage: '$sn'"

if [[ $EUID -ne 0 ]] ; then
    echo "$sn: vous devez etre root"
    exit 1
fi

if [[ $# -ne 1 ]] ; then
    echo "$usage USERNAME"
    exit 2
fi

username=$1

id $username > /dev/null 2>&1

if [[ $? -ne 0 ]] ; then
    echo "$sn: '$username' n'existe pas."
    exit 3
fi

rm -rf /web/$username

if [[ $? -ne 0 ]] ; then
    echo "$sn: erreur lors de la suppression de '/web/$username'"
    exit 4
fi

# recuperer l'adressse email avant suppression de l'utilisateur.

email=$(grep "^$username:" /etc/passwd | cut -d : -f 5)

userdel -r -f $username &>/dev/bull

if [[ $? -ne 0 ]] ; then
    echo "$sn: le repertoire '/web/$username' n'existe pas"
    exit 5
fi

if [[ -z $email ]] ; then
    ./mumail $email "Suppression compte" "Votre compte a ete supprimé"
    if [[ $? -ne 0 ]] ; then
        echo "$sn: echec lors de l'envoie du mail."
        exit 6
    fi
fi

