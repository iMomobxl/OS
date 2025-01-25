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

nb_file=0
total_siwe=0

# espace dans un nom de fichier, ne prend pas en compte les espace de cette maniere
while read path ; do
    $nb_files=$((nb_files + 1))
    total_size=$((($total_size + $(stat -c %s "$path"))))
done < < (find "$1" -type f -print)

echo "Nombre de fichiers: $nb_files"
echo "Taille des fichiers: $total_siwe"