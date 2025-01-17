#!/bin/bash

#######################
######## ex_999 #######
## remove.sh script ###
#######################

## check if you are root.
if [[ $EUID -ne 0 ]] ; then
    echo "You must be root."
    exit 1
fi

## check uniquement un parameter
if [[ $# -ne 1 ]] ; then
    echo "You must provide only one parameter"
    exit 2
fi

## enregistrement du parametre
script_name=$1
install_dir=./.trash

## check if $1 is file
if [[ ! -f $script_name ]] ; then
    echo "Usage: $(basename $1): not a file"
    exit 3
fi

## check if file not null
if [[ ! -s $script_name ]] ; then
    rm "$script_name"
    if [[ $? -ne 0 ]] ; then
        echo "Error: couldn't delete file '$script_name'"
        exit 4
    fi
    echo "File has been deleted because it's empty"
    exit 0
fi

## check if install_dir is create
if [[ ! -d $install_dir ]] ; then
    echo "creation de "$install_dir""
    mkdir "$install_dir"
    if [[ $? -ne 0 ]] ; then
        echo "Error create .trash directory"
        exit 5
    fi
fi

mv "$script_name" "$install_dir"

## check status of the last command
if [[ $? -ne 0 ]] ; then
    echo "Error copy"
    exit 6
fi

echo "le script a ete envoyer a la poubelle"
exit 0

            