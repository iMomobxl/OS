#!/bin/bash

sn=$(basename $0)
log=post_install.log

echo "== Debut du script - $(date) ==" >> $log
if [[ $EUID -ne 0 ]] ; then
    echo "Vous devez etre root" 
    echo "ERREUR: l'utilisateur n'est pas root" >> $log
    echo "== Fin du script - $(date) ==" >> $log
    exit 1
fi

# verifie la liste des utilisateurs
if [[ $# -ne 1 ]] ; then
    echo "Usage: '$sn' USERLIST"
    echo "ERREUR: nombre de parametres incorrets" >> $log
    echo "== Fin du script - $(date) ==" >> $log
    exit 2
fi

users_list=$1

# | tee -a $log -> affiche
if [[ ! -f "$user_list" ]] ; then
    echo "$sn: '$user_list'" >> $log
    echo "ERREUR: '$user_list' n'est pas fichier" >> $log
    echo "== Fin du script - $(date) ==" >> $log
    exit 3
fi

echo "-- Creation des utilisateurs - $(date)" >> $log
while read line ; do
    user_name=$(echo $line | cut -d : -f 1)
    user_passwd=$(echo $line | cut -d : -f 2)
    id $user_name > /dev/null 2>&1
    if [[ $? -eq 0 ]] ; then
        echo "INFO: utilisateur $user_name existe" >> $log
    else
        echo "Creation de l'utilisateur $user_name" >> $log
        cpasswd=$(openssl passwd -6 $user_passwd)
        useradd -m -s /bin/bash -p $cpasswd $user_name
        if [[ $? -ne 0 ]] ; then
            echo "'$sn': impossible d'ajouter $user_name"
            echo "ERREUR: impossible d'ajouter $user_name" >> $log
            echo "== Fin du script - $(date) ==" >> $log
            exit 4 ##### ATTENTION
        fi
    fi
done < "$user_list"

echo "-- Creation des repertoires - $(date) --" >> $log

prof_dir=/data/prof
if [[ -d "$prof_dir" ]] ; then
    echo "INFO: '$prof_dir' existe deja" >> $log
else 
    mkdir -p "$prof_dir"
    if [[ $? -ne 0 ]] ; then
        echo "'$sn': impossible de creer '$prof_dir'"
        echo "ERREUR: impossible de creer '$prof_dir'" >> $log
        echo "== Fin du script - $(date) ==" >> $log
        exit 5 ##### ATTENTION
    fi
fi

chown prof "$prof_dir" && chmod 700 "$prof_dir"
if [[ $? -eq 0 ]] ; then
        echo "INFO: acces a '$prof_dir' donnees" >> $log
    else
        echo "'$sn': impossible de donner acces a '$prof_dir'"
        echo "ERREUR: impossible de donner acces a '$prof_dir'" >> $log
        echo "== Fin du script - $(date) ==" >> $log
        exit 6 ##### ATTENTION
    fi
fi

share_dir=/data/prof
if [[ -d "$share_dir" ]] ; then
    echo "INFO: '$share_dir' existe deja" >> $log
else 
    mkdir -p "$prof_dir"
    if [[ $? -ne 0 ]] ; then
        echo "'$sn': impossible de creer '$share_dir'"
        echo "ERREUR: impossible de creer '$share_dir'" >> $log
        echo "== Fin du script - $(date) ==" >> $log
        exit 7 ##### ATTENTION
    fi
fi

chmod 777 "$share_dir"

if [[ $? -eq 0 ]] ; then
        echo "INFO: acces a '$share_dir' donnees" >> $log
    else
        echo "'$sn': impossible de donner acces a '$share_dir'"
        echo "ERREUR: impossible de donner acces a '$share_dir'" >> $log
        echo "== Fin du script - $(date) ==" >> $log
        exit 8 ##### ATTENTION
    fi
fi

echo "-- Installation de Codium - $(date) --" >> $log
which codium > /dev/null > 2>&1
if [[ $? -eq 0 ]] ; then
    echo "INFO: codium existe" >> $log
else
    ./muget.sh https://vscodium.com/download/codium
    if [[ $? -eq 0 ]] ; then
        echo "INFO: codium telecharger avec success"
    else
        echo "'$sn': impossible de telecharger codium"
        echo "ERREUR: impossible de telecharger codium" >> $log
        echo "== Fin du script - $(date) ==" >> $log
        exit 9 ##### ATTENTION
    fi
    mkdir /opt/codium
    copie codium /opt/codium
    if [[ $? -ne 0 ]] ; then
        echo "'$sn': impossible de copier codium dans /opt/codium"
        echo "ERREUR: impossible de copier codium dans /opt/codium" >> $log
        echo "== Fin du script - $(date) ==" >> $log
        exit 10
    fi
    chmod a+x /opt/codium
    # test + log
    ln -s /opt/codium/codium /usr/local/bin/codium
    # test + log
fi
echo "== Fin du script - $(date) ==" >> $log
