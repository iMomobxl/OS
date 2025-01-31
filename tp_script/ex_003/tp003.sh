#!/bin/bash

#######################
######## tp03 #########
## ................. ##
#######################

### Gestion des accès
#
# 1. Donnez les noms d’utilisateur des comptes qui peuvent se connecter sur le système.
( grep -f /etc/shells /etc/passwd ) | cut -d : -f 1 | tr "\n" " "
# correction
grep -f /etc/shells /etc/passwd | cut -d : -f 1

# 2. Sur base du contenu du fichier /etc/group, retrouvez le nom de tous le groupes dont vous faites parties 
# (le résultat doit être équivalant à la commande groups)
cat /etc/group | grep "^user$" | cut -d : -f 1 | tr "\n" " "
# correction 1
grep -E "\b$(whoami)\b" /etc/group | cut -d : -f 1 | tr "\n" " " ; echo
# correction 2
( grep -P "^\w+:x:$(id -g):" /etc/group && grep -P "^\w+:x:\d+:.*\b$(whoami)\b" /etc/group ) | cut -d : -f 1 | tr "\n" " " ; echo

# 3. Le responsable R&D de votre entreprise vient vous trouver. Un nouveau projet de robotique vient
# de démarrer et il voudrait que ses équipes puissent collaborer. Il y a les équipes « énergie »,
# « mécanique », « électronique » et « software ». Chaque équipe doit avoir son propre répertoire
# accessible en lecture uniquement aux autres équipes. Aussi, chaque équipe doit avoir un espace
# restreint accessible uniquement aux membres de l’équipe où seront stockées les données non
# encore validées
# Voici les différentes étapes pour résoudre l’exercice, donner les commandes correspondantes :
# (a) créer les groupes de chaque équipe;
sudo su
groupadd ener   # id: 1001 (energie)
groupadd meca   # id: 1002 (mecanique)
groupadd elec   # id: 1003 (electronique)
groupadd soft   # id: 1004 (software)
su user

# (b) créer les utilisateurs et les placez dans ces groupes en fonction de leur équipe;
sudo su
useradd -m user_1 -p password -g 1001 -c "energie user_1"
useradd -m user_2 -p password -g 1002 -c "mecanique user_2"
useradd -m user_3 -p password -g 1003 -c "electronique user_3"
useradd -m user_4 -p password -g 1004 -c "software user_4"

# (autre solution)
useradd -m user_1 -p password -c "energie user_1"
useradd -m user_2 -p password -c "mecanique user_2"
useradd -m user_3 -p password -c "electronique user_3"
useradd -m user_4 -p password -c "software user_4"

usermod -a -G ener user_1
usermod -a -G meca user_2
usermod -a -G elec user_3
usermod -a -G soft user_4

apt-get install members

members -t ener
members -t meca
members -t elec
members -t soft

su user

# (c) créer le répertoire /projet avec les permissions adéquates;
cd ~
mkdir ./projet
sudo chmod 755 ./projet

# (d) dans /projet, créer un répertoire par équipe avec les permissions adéquates;
cd /projet
mkdir ener_rep meca_rep soft_rep elec_rep
sudo chown :ener ener_rep
sudo chown :meca meca_rep
sudo chown :soft soft_rep
sudo chown :elec elec_rep
sudo chmod 774 *_rep         #drwxrwxr--

# (e) dans chaque répertoire d’équipe, créer un répertoire restricted accessible uniquement à l’équipe;
mkdir ener_rep/restricted
mkdir meca_rep/restricted
mkdir elec_rep/restricted
mkdir soft_rep/restricted
sudo chmod -R 770 *_rep/restricted

# Afin de valider votre solution, identifiez-vous avec des utilisateurs de différentes équipes 
# et essayez de différentes opérations sur les dossiers et les répertoires.

# correction
useradd -g energie m-m -s /bin/bash anatol
passwd anatol
useradd -g mecanique m-m -s /bin/bash bene
passwd bene
useradd -g electronique m-m -s /bin/bash chris
passwd chris
useradd -g software m-m -s /bin/bash dora
passwd dora

mkdir -p /project/{energie,mecanique,electronique,software}/restricted
chgrp -R energie /project/energie/
chgrp -R mecanique /project/mecanique/
chgrp -R electronique /project/electronique/
chgrp -R software /project/software/
chmod g+w /project/*
chmod 770 /project/*/restricted
ls -la /project/*

############################################################################
# 4. Ce sont les examens à l’EPHEC. Vous gérez le serveur sur lequel les étudiants déposeront leurs
# travaux. Créez un répertoire pour chaque étudiant dans le répertoire /examephec. Les étudiants
# ne pourront pas voir le contenu de ce dernier, mais pourront accéder à leur propre répertoire,
# et uniquement ce dernier. Les professeurs, quant à eux, pourront voir le contenu de tous les
# répertoires de tous les étudiants, ainsi que le contenu de examephec.
# Voici les différentes étapes pour résoudre l’exercice, donner les commandes correspondantes 
# (a) créer le groupe examephec;
groupadd exemephec

# (b) créer un compte enseignant et le placer dans le(s) groupe(s) approprié(s);
useradd -m teacher -p password -g exemephec -c teacher

# (c) créer des comptes étudiants et les placer dans le(s) groupe(s) approprié(s);
useradd -m student_1 -p password -c "student id 1"
useradd -m student_2 -p password -c "student id 2"

usermod -a -G examephec student_{1,2}

# (d) créer le répertoire /examephec avec les permissions appropriées;
mkdir ./examephec
sudo chown teacher:examephec ./examephec
sudo chmod 710 ./examephec

# (e) dans /examephec, créer les répertoires des étudiants avec les permissions appropriées;
mkdir ./examephec/student_1
mkdir ./examephec/student_2
sudo chown student1:examephec ./examephec/student_1
sudo chown student2:examephec ./examephec/student_2
sudo chmod 700 ./examephec/student_1
sudo chmod 700 ./examephec/student_2

# Afin de valider votre solution, identifiez-vous avec des comptes étudiants et le compte enseignant,
# et essayez de différentes opérations sur les dossiers et les répertoires.

# 5. Les examens sont finis. Quelle(s) commande(s) devez-vous utiliser pour que les étudiants ne
# puissent plus rien modifier dans leurs répertoires.
sudo chown -R teacher:examephec ./examephec/student_{1,2}
sudo chmod 710 ./examephec/student_{1,2}


# correction
groupadd examen
useradd -m -s /bin/bash -G examen teach1
passwd teach1
useradd -m -s /bin/bash stud1
passwd stud1
useradd -m -s /bin/bash stud2
passwd stud2
useradd -m -s /bin/bash stud3
passwd stud3

mkdir -p /examen/stud{1..3}
chgrp -R examen /examen
chown stud1 /examen/stud1
chown stud1 /examen/stud2
chown stud1 /examen/stud3 # chown stud1:examen /exemen/stud1/
chmod o-r /examen/ # chmod 555 /examen
chmod o-rx /examen/* # chmod 750 /examen
ls -laR /examen/

chmod -R a-w /examen # chmod -R 444 /examen retire les droit w de tt le monde mais le proprio peut remettre le w

# en root
chown root /examen/ # change le proprio des fichier a root -> stud1 ne peut plus modifier permission
