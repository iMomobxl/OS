#!/bin/bash

sn=$(basename $0)

if [[ $EUID -ne 0 ]] ; then
    echo "Il faut etre root"
    exit 1
fi

if [[ $# -lt 1 || $# -gt 3 ]] ; then
    echo "Usage: $sn NOMUTILISATEUR [PASSWORD] [SHELL]"
    exit 2
fi

username=$1
password=${2:-password}
shell=${3:-/bin/bash}

id $username > /dev/null 2>&1

if [[ $? -eq 0 ]] ; then
    echo "$sn: '$username' existe deja"
    exit 3
fi

# verifie si le shell existe
grep "^$shell$" /etc/shell > /dev/null 2>&1

# which $shell > /dev/null 2>&1
# identique au grep

if [[ $? -ne 0 ]] ; then
    echo "$sn: '$shell' n'est pas shell valide"
    exit 4
fi

# chiffrer le password
crypt_password=$(openssl passwd -6 $password)

# creer l'utilisateur
useradd -p $crypt_password -m -s $shell $username