#!/bin/bash

# verifie si il existe des parametres
if [[ "$#" -eq 0 || "$#" -gt 2 ]] ; then
    echo "il faut 1 ou 2 parametres (ni plus ni moin)"
    exit 1
fi

# verifie si le deuxieme parametre est une chaine non vide
if [[ -n "$2" ]] ; then
    echo "le repertoire choisit est $2"
    SCRIPTPATH=$2
else
    echo "pas de repertoire choisit /opt/perso_scripts/ par defaut"
    SCRIPTPATH="/opt/perso_scripts/"
fi

# verifie si le $SCRIPTPATH existe et un repertoire
if [[ ! -d "$SCRIPTPATH" ]] ; then
    echo "creation du repertoire"
    mkdir -p "$SCRIPTPATH"
    if [[ $? -ne 0 ]] ; then
        echo "erreur lors de la creation du repertoire"
        exit 1
    fi
fi

# verifie si le script est deja dans le repertoire
if [[ -e $SCRIPTPATH ]] ; then
    echo "Un script portant le meme nom existe déjà dans le repertoire"
    exit 1
else    
    echo "le script ne se trouve pas dans le repertoire voulu"
fi

# copie du script dqns le repertoire $SCRIPTPATH
echo "copie du fichier dans le repertoire"
cp "$1" "$SCRIPTPATH"

# donne les droits d'execution
echo "donne les droits d'execution du script"
chmon u+x "$SCRIPTPATH$1"
if [[ $? -ne 0 ]] ; then
    echo "erreur lors de l'attribution des droits"
    exit 1
fi

echo "tout est oki"
exit 0
