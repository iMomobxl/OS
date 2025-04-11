#!/bin/bash

sn=$(basename $0)
usage="Usage: '$sn'"

# verifie le nombre de paramatre (3)
if [[ $# -lt 3 || $# -gt 3 ]] ; then
    echo "$usage EMAIL SUJET CORPS"
    exit 1
fi

email=$1
sujet=$2
corps=$3

# if [[ -z $1 || -z $2 || -z $3 ]] ; then
#     echo "un parametre est une chaine vide"
#     exit 2
# fi

# random de 1 a 10
random=$(( $RANDOM % 11 + 1 ))

case $random in
    10)
        echo "adresse email pas valide"
        exit 3
        ;;
    9)
        echo "une erreur c'est produite"
        exit 4
        ;;
    *)
        echo "envoie de l'email oki"
        exit 0
        ;;
esac