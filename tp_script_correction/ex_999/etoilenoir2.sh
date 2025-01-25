#1!/bin/bash

sn=$(basename $0)

if [[ $# -ne 1 ]] ; then
    echo "Usage: $sn il faut 1 parametre"
    exit 1
fi

dirname=$1

if [[ ! -d "$dirname" ]] ; then
    echo "$sn n'est pas un repertoire"
    exit 2
fi

nb_file=$(find "$1" -type f -print | wc -l)
total_siwe=$(du -bs "$1" | cut -f 1)

echo "Nombre de fichiers: $nb_files"
echo "Taille des fichiers: $total_siwe"