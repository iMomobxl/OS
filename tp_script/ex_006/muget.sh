#!/bin/bash

sn=$(basename $0)
usage="Usage: '$sn'"
# check le nombre de parametre
if [[ $# -lt 1 || $# -gt 2 ]] ; then
    echo "$usage URL [FILENAME]"
    exit 1
fi

url=$1

# check [FILENAME]
if [[ $# -eq 1 ]] ; then
    filename=$(basename $url)
else
    filename=$2
fi

# check si [FILENAME] existe
if [[ -f "$filename" ]] ; then
    echo "$sn: le nom du fichier $filename existe deja."
    exit 2
fi

# wget $url -o $filename

# genere un nombre entre [1, 16]
random_nbr=$((1 + $RANDOM % 16))
# echo $random_nbr

case $random_nbr in
    16)
        echo "Erreur lors du telechargement"
        exit 3
        ;;
    15)
        echo "#!/bin/bash" > "$filename"
        chmod a+x "$filename"
        echo "echo 'je suis un fichier corrompu'" >> $filename
        ;;
    *)
        echo "#!/bin/bash" > "$filename"
        chmod a+x "$filename"
        echo "echo 'je suis $filename'" >> $filename
        ;;
esac

exit 0
