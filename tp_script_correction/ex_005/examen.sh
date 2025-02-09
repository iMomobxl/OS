#!/bin/bash

# fichier 'listusers'  groupd:username:passowrd
sn=$(basename $0)

if [[ $EUID -ne 0 ]] ; then
    echo "$sn: vous devez etre root"
    exit 1
fi

if [[ $# -ne 1 ]] ; then
    echo "Usage: $sn LISTUSERS"
    exit 2
fi

users_file=$1

if [[ ! -f "$users_file" ]] ; then
    echo "$sn: '$users_file' n'est pas un fichier"
    exit 3
fi

rm -R /examen 2> /dev/null
mkdir /examen

groupdel -f examen 2> /dev/null
groupadd examen

# on suppose que les champ du fichier sont valides, pas besoin de verifier chaques champ
while read line ; do
    user_type=$(echo $line | cut -d : -f 1)
    user_name=$(echo $line | cut -d : -f 2)
    user_pass=$(echo $line | cut -d : -f 3)

    # verifie si l'utilisateur existe deja
    id $user_name > /dev/null 2>&1
    if [[ $? -ne 0 ]] ; then
        cpass=$(openssl passwd -6 $user_pass)
        useradd -p $cpass -m -s /bin/bash $user_name
    fi
    if [[ $user_type == "prof" ]] ; then
        usermod -aG examen $user_name
    else 
        mkdir /examen/$user_name
        chown $user_name /examen/$user_name
    fi
done < "$users_file"

chgrp -R examen /examen
chmod 751 /examen   
chmod 750 /examen/*

