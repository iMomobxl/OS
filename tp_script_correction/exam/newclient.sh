#!/bin/bash

sn=$(basename $0)
usage="Usage: '$sn'"

if [[ $EUID -ne 0 ]] ; then
    echo "$sn: vous devez etre root"
    exit 1
fi

if [[ $# -ne 2 ]] ; then
    echo "$usage USERNAME EMAIL"
    exit 2
fi

username=$1
email=$2

id $username > /dev/null 2>&1
if [[ $? -eq 0 ]] ; then
    echo "$sn: '$username' existe deja."
    exit 3
fi

passwd=$(cat /dev/urandom | tr -cd '[:alnum:]' | head -c 16)
cpasswd=$(openssl passwd -6 $passwd)

useradd -c $email -p $cpasswd -m -s /bin/bash $user_name

if [[ $? -ne 0 ]] ; then
    echo "$sn: Erreur lors de la creation de '$username'"
    exit 4
fi

mkdir /web/$username

if [[ $? -ne 0 ]] ; then
    echo "$sn: Erreur lors de la creation de '/web/$username'"
    userdel -r $username
    exit 5
fi

chown $username:www-data /web/$username

if [[ $? -ne 0 ]] ; then
    echo "$sn: Erreur lors du changement de proprietaire."
    userdel -r $username
    exit 6
fi

chmod 770 $user_name

if [[ $? -ne 0 ]] ; then
    echo "$sn: Erreur lors l'attribution des droit a '$username'"
    userdel -r $username
    exit 7
fi

ln -s /web/$user_name /home/$user_name/web

if [[ $? -ne 0 ]] ; then
    echo "$sn: Erreur lors de la creation de lien vers '/web/$username'"
    userdel -r $username
    exit 8
fi

./mumail $email "Creation compte" "Votre mot de passe: $passwd"
if [[ $? -ne 0 ]] ; then
    userdel -r $username
    rm -R /web/$username
    echo "$sn: eche de l'envoie du mail."
    exit 9
fi