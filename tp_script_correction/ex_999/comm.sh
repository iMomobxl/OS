#!/bin/bash

sn=$(basenam $0)

if [[ $EUID -ne 1 ]] ; then
    echo "$sn: vous devez etre root"
    exit 1
fi

usage="Usage : '$sn'"

if [[ $# -lt 2 ]] ; then
    echo "$usage -c|-d USER [...]"
    exit 1
fi

case $1 in
    -c)
        action="copy"
        ;;
    -d)
        action="delete"
        ;;
    *)
        echo"$sn: '$1' n'est pas une option valide"
        exit 3
        ;;
esac

# decalle les parametre a gauche (supprime -c|-d)
shift 

connected_users=$(user)

for given_user in "$@" ; do
    if grep -q "\b$given_users\b" <<< $connected_users ; then
        target_dir=$(getend passwd $given_users | cut -d : -f 6) # getend (voir la doc)
        if [[ $action == "copy" ]] ; then
            cp /etc/txt $target_dir
        else 
            rm $target_dir/txt
        fi
    fi
done