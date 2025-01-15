#!/bin/bash

#### boucle pour chqaues script ####
# verfier si on est root pour des script system
# verifier le nombre de parametre
# valider les parametres:
# 


sn=$(basename $0)
# verifie si je suis root
if [[ $EUID -ne 0 ]] ; then
    echo "$sn: Vous devez etre root"
    exit 1
fi

# verifie le nombre de parametre
if [[ $# lt 1 || $# gt 2 ]] ; then
    echo "Usage: $sn SCRIPT_NAME [INSTALL_DIR]"
    exit 2
fi

# Enregistrement des parametres
# pas de majuscule dans les nom de variable, reserver pour les variable global
script_name=$1
install_dir=$2

# verifie si install_dir est vide
if [[ -z "$install_dir" ]] ; then
    install_dir="/opt/perso_scripts"
fi

# valider les parametres
# verifie si le parametre est un fichier
if [[ ! -f "$script_name" ]] ; then # ajout les gillemets autour d'une variable en cas d'espace
    echo "$sn: '$script_name' n'est pas un fichier"
    exit 3
fi

# verifie si le chemin existe sinon le creer (-p pour creer les parents)
if [[ ! -d "$install_dir" ]] ; then
    mkdir -p "$install_dir"
fi

# verifie si le script est deja dans le repertoire
if [[ -f "$install_dir/$script_name" ]] ; then  
    echo "$sn: '$install_dir/$script_name' existe déjà"
    exit 4
fi

# Installation du script
cp "$script_name" "$install_dir"
if [[ $? -ne 0 ]] ; then
    echo "$sn: echec du copie de '$script_name' dans '$install_dir'"
    exit 5
fi

# donne les droits pour pouvoir s'executer
chmod a+x "$install_dir/$script_name"

ln -s "$install_dir/$script_name" /usr/local/bin/${script_name%.*} # %.* supprime l'extention .sh, etc..







