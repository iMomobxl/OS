#!/bin/bash

sn=$(basename $0)
usage="Usage: '$sn'"

if [[ $EUID -ne 0 ]] ; then
    echo "vous devez etre root"
    exit 1
fi

users_file="listusers"

if [[ ! -f "$users_file" ]] ; then
    echo "'$users_file' n'est pas un fichier ou n'existe pas"
    exit 2
fi

bash=/bin/bash

while read line ; do
    user_name=$(echo $line)

    # verifie si l'utilisateur existe deja
    id $user_name > /dev/null 2>&1
    if [[ $? -ne 0 ]] ; then
        passwd=$(cat /dev/urandom | tr -cd '[:alnum:]' | head -c 16)
        # echo "passwd: $passwd"
        cpasswd=$(openssl passwd -6 $passwd)
        # echo "cpasswd: $cpasswd"
        useradd -p $cpasswd -m -s $bash $user_name
        # verifie que l'uilisateur a bien ete creer
        if [[ $? -ne 0 ]] ; then
            echo "erreur lors de la creation de l'utilisateur"
            exit 3
        fi

        mkdir -p /web/$user_name
        chown $user_name:$user_name /web/$user_name
        chmod 700 $user_name
        ln -s /web/$user_name /home/$user_name/web
        # test pour chaques commande necessaire?

        # envoie du mail
        ./munail.sh "$user_name@gmail.com" "votre mot de pass" $passwd
        if [[ $? -ne 0 ]] ; then
            echo "erreur lors de envoie du mail"
            ./deleteclient.sh $user_name
        fi
    fi
done < "$users_file"

if [[ $? -ne 0 ]] ; then
    # echo "erreur lors de la boucle de creation utlisateur"
    exit 4
fi

# echo "script oki"