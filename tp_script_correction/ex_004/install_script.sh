#!/bin/bash

# execution en tand que root
if [[ $EUID -ne 0 ]] ; then
    echo "$(basename $0): You must be root to execute this script"
    exit 1
fi

# verification des parametres
if [[ $# -lt 1 || $# -gt 2 ]] ; then
    echo "Usage: $(basename $0) SCRIPTNAME [INSTALLDIR]"
    exit 2
fi

# Enregistrement des entrees
script_name=$1
install_dir=$2

# validation des entrees
if [[ ! -f $script_name ]] ; then
    echo "$(basename $0): '$script_name does not exists"
    exit 3
fi
if [[ -z "$install_dir" ]] ; then
    install_dir=/opt/perso_scripts
fi

# installation du script
[[ -d "$install_dir" ]] || mkdir -p "$install_dir"
cp "$script_name" "$install_dir"
chmod a+x "$install_dir/$script_name"
ln -fs "$install_dir/$script_name" /usr/local/bin/${script_name%.*}

echo "OK"