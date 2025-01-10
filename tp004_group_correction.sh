#!/bin/bash

# Test le nombre de parametre
if [[ $# -gt 1 ]] ; then
    echo "Usage: $(basename $0) [USERNAME]"
    exit 1
fi

# Valisation du 1er parametre
user=$1
if [[ -z $user ]] ; then # check si user est vide = pas de parametre
    user=$(whoami)
else
    id $user > /dev/null 2>&1
    if [[ $? -eq 0 ]] ; then # check si la derniere commande n'a pas d'erreur
        echo "$(basename $0): '$user' n'existe pas"
        exit 2 # tjs les valeurs de exit different
    fi
fi

# affiche l'utilisateur
echo $user

groups=""
while read line ; do
    users_in_group=$(echo $line | cut -d : -f 4)
    echo $users_in_group | grep "\b$user\b" > /dev/null 2>&1
    if [[ $? -eq 0 ]] ; then
        current_group=$(echo $line | cut -d : f 1)
        groups="$groups $current_group"
    fi
done > /etc/group

echo $groups
