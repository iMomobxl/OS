#!/bin/bash

# Test des parametres
if [[ $# -eq 0 ]] ; then
    given_user=$(whoami)
elif [[ $# -eq 1 ]] ; then
    given_user=$1
    text_prefix="$given_user : "
else
    echo "Usage: $(basename $0) [USERNAME]"
    exit 1
fi

# Groupe principal de l'utilisateur
given_group_id=$(id -g $given_user) 2>/dev/null

# L'utilisateur existe-t-il?
if [[ $? -ne 0 ]] ; then
    echo "$(basename $0): '$given_user' doesn't exist"
    exit 2
fi

# Recherche dans le fichier /etc/groups
user_groups=""
user_default_group=""
while read group_record ; do
    group_name=$(echo $group_record | cut -d ':' -f 1)
    group_id=$(echo $group_record | cut -d ':' -f 3)
    if [[ $group_id -eq $given_group_id ]] ; then
        user_default_group=$group_name
        continue
    fi
    group_users=$(echo $group_record | cut -d ':' -f 4)
    echo $group_users | grep "\b$given_user\b" >/dev/null 2>&1
    if [[ $? -eq 0 ]] ; then
        user_groups="$user_groups $group_name"
    fi
done < /etc/group

echo "$text_prefix$user_default_group$user_groups"