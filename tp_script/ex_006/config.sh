#!/bin/bash

sn=$(basename $0)
usage="Usage: '$sn'"
journal=./journal

echo $(date) "Message: Lancement du script '$sn'" > $journal

user_file=listeusers

# check si on est root
if [[ $EUID -ne 0 ]] ; then
    message="Erreur: Vous devez etre root"
    echo $(date) $message >> $journal
    exit 1
fi

# check le nombre de parametre
if [[ $# -ne 0 ]] ; then 
    message="Erreur: $usage pas de parametre autorisé"
    echo $(date) $message >> $journal
    exit 2
fi

# creation des utilisateurs
while read line ; do
    user_name=$(echo $line | cut -d : -f 1)
    user_pass=$(echo $line | cut -d : -f 2)
    id $user_name > /dev/null 2>&1
    if [[ $? -eq 0 ]] ; then
        message="Erreur: l'utilisateur '$user_name' existe deja."
        echo $(date) $message >> $journal
    else
        cpass=$(openssl passwd -6 $user_pass)
        echo $(date) "Message: Chiffrement password de '$user_name'" >> $journal
        useradd -p $cpass -m -s /bin/bash $user_name
        echo $(date) "Message: Creation de l'utilisateur '$user_name'" >> $journal
    fi
done < "$user_file"

# creation du dossier prof
dir_prof=/data/prof

if [[ -d $dir_prof ]] ; then
    message="Erreur: le repertoire '$dir_prof' existe deja."
    echo $(date) $message >> $journal
else
    mkdir -p "$dir_prof"
    echo $(date) "Message: Creation du dossier '$dir_prof'" >> $journal
fi

# creation du dossier shared
dir_shared=/data/shared

if [[ -d $dir_shared ]] ; then
    message="Erreur: le repertoire '$dir_shared' existe deja."
    echo $(date) $message >> $journal
else
    mkdir -p "$dir_shared"
    echo $(date) "Message: Creation du dossier '$dir_shared'" >> $journal
fi

# donne les droits au dossier
chown prof "$dir_prof"
echo $(date) "Message: Donne les droit du dossier '$dir_prof' a l'utilisateur prof" >> $journal

# supprime l'acces a etudiant
chmod 750 "$dir_prof"
echo $(date) "Message: Supprime l'acces de l'utilisateur 'etudiant' au dossier '$dir_prof'" >> $journal

# telechargement de VSCodium
url="https://vscodium.com/download/codium"
url_base=$(basename "$url")
path=/opt/vscodium

# check si path existe
echo $(date) "Message: Verification du repertoire '$path'" >> $journal
if [[ -d "$path" ]] ; then
    echo $(date) "Erreur: Le repertoire '$path' existe deja." >> $journal
else    
    mkdir -p "$path"
    echo $(date) "Message: Creation du repertoire '$path'" >> $journal
fi

# execution du script muget
echo $(date) "Message: Lancement du script 'muget.sh'" >> $journal
./muget.sh "$url" > /dev/null 2>&1

if [[ $? -ne 0 ]] ; then
    message="Erreur: le lancement du script 'muget.sh' a foiré" >> $journal
    echo $(date) $message >> $journal
fi

# copie du logiciel dans /opt/vscodium
echo $(date) "Message: copie du logiciel '$url_base' dans '$path'" >> $journal
cp "$url_base" "$path"

if [[ $? -ne 0 ]] ; then
    message="Erreur: la copie du logiciel '$url_base' dans '$path'" >> $journal
    echo $(date) $message >> $journal
fi

# rend le logiciel executable
echo $(date) "Message: rendre le logiciel executable" >> $journal
chmod a+x "$path/$url_base"
if [[ $? -ne 0 ]] ; then
    message="Erreur: la copie du logiciel '$url_base' dans '$path'" >> $journal
    echo $(date) $message >> $journal
fi

# creation d'un lien symbolique
echo $(date) "Message: creation d'un lien symbolique" >> $journal
ln -fs "$path/$url_base" "/usr/local/bin/${url_base%.*}"
if [[ $? -ne 0 ]] ; then
    message="Erreur: la creation du lien a foiré'" >> $journal
    echo $(date) $message >> $journal
fi

######################
# possibilité de creer une fonction pour la gestion des messages de $journal, rend le code plus propre/lisible
# possibilite de creer des groupe pour prof/etudiant
######################


#############################################
# section developpement: supprime tout ce que le script a fait

# suppression des utilsateurs
deluser --remove-home prof > /dev/null 2>&1
if [[ $? -ne 0 ]] ; then
    message="Erreur: le script ne peut supprimer l'utilsateur 'prof'"
    echo $(date) $message >> $journal
else 
    echo $(date) "Suppression de l'utilsateur 'prof'" >> $journal
fi 
deluser --remove-home etudiant > /dev/null 2>&1
if [[ $? -ne 0 ]] ; then
    message="Erreur: le script ne peut supprimer l'utilsateur 'etudiant'"
    echo $(date) $message >> $journal
else 
    echo $(date) "Suppression de l'utilsateur 'etudiant'" >> $journal
fi 

# suppression des dossiers
rm -r "$dir_prof" > /dev/null 2>&1
if [[ $? -ne 0 ]] ; then
    message="Erreur: le script ne peut supprimer le repertoire '$dir_prof'"
    echo $(date) $message >> $journal
else 
    echo $(date) "Suppression du repertoire '$dir_prof'" >> $journal
fi 
rm -r "$dir_shared" > /dev/null 2>&1
if [[ $? -ne 0 ]] ; then
    message="Erreur: le script ne peut supprimer le repertoire '$dir_shared'"
    echo $(date) $message >> $journal
else 
    echo $(date) "Suppression du repertoire '$dir_shared'" >> $journal
fi 
rm -r "$path" > /dev/null 2>&1
if [[ $? -ne 0 ]] ; then
    message="Erreur: le script ne peut supprimer le repertoire '$path'"
    echo $(date) $message >> $journal
else 
    echo $(date) "Suppression du repertoire '$path'" >> $journal
fi 

# suppresion du lien
rm /usr/local/bin/codium
if [[ $? -ne 0 ]] ; then
    message="Erreur: le script ne peut supprimer le lien '/usr/local/bin/codium'"
    echo $(date) $message >> $journal
else 
    echo $(date) "Suppression du lien '/usr/local/bin/codium'" >> $journal
fi 
