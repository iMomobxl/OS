#!/bin/bash

sn=$(basename $0)
# Vérification des paramètres
if [[ $# -lt 1 || $# -gt 2 ]] ; then
echo "Usage:␣$sn␣URL␣[FILENAME]"
exit 1
fi

# Enregistrement des entrées
url=$1
filename=$2

# Validation des entrées
if [[ -z "$filename" ]] ; then
    filename=$(basename $url)
fi

# Simulation du temps de téléchargement
sleep $(($RANDOM % 4 + 2))

# Génération des différents cas
random_number=$(($RANDOM % 16))

case $random_number in
    0)
        # Téléchargement échoué
        echo "$sn: unable to download '$url'"
        exit 3
        ;;
    1)
        # Téléchargement d’un fichier corrompu
        echo "#!/bin/bash" > $filename
        echo >> $filename
        echo 'echo "Je suis un fichier corrompu"' >> $filename
        exit 2
        ;;
    *)
        # Téléchargement réussi
        echo "#!/bin/bash" > $filename
        echo >> $filename
        echo 'echo "Je suis $(basename $0)"' >> $filename
        ;;
esac