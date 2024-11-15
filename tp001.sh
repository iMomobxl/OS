#!/bin/bash

#######################
######## tp01 #########
## ................. ##
#######################

####### COMMANDES: #######
# 
# 1. Cherchez dans l’aide de la commande date la manière d’afficher la date dans les formats suivants :
# (a) mer 7 fev 2024 20:32:55 CET
date
# (b)
date +"%d/%m/%Y %H:%M:%S"
date +"%d/%m/%Y %X"
# (c)
date +"%Y%m%d_%H%M%S"
# (d)
date --date='@1707334375'
# (d) correction
date +"%s"
# (e)
date --date='@1718208000'
# (e) correction
date -d @1718208000
# 2. Affichez le calendrier de février 2024 avec un mois avant et un mois après.
cal -3 2 2024
# 3. Affichez le calendrier de septembre 1752.
cal 9 1752
# 4. Effacez l’écran.
clear

######## REPERTOIRES: #######
#
# 1. Créez l’arborescence
mkdir test test/dir1 test/dir2 test/dir1/dir11 test/dir1/dir12 test/dir2/dir21 test/dir2/dir22 
# 1 correction
mkdir test
mkdir test/dir1
mkdir test/dir1/dir11
mkdir test/dir1/dir12
mkdir test/dir2
mkdir test/dir2/dir21
mkdir test/dir2/dir22

mkdir -p test/dir{1/dir1{1,2},2/dir2{1,2}}

# 2. En utilisant un chemin relatif, rendez-vous dans le répertoire dir 22
cd ~/test/dir2/dir22
# 2 correction
cd test/dir2/dir22

# 3. Affichez le répertoire courant.
pwd

# 4. En utilisant un chemin absolu, rendez-vous dans le répertoire dir11.
cd /home/user/test/dir1/dir11

# 5. Déplacez le répertoire dir1 dans dir2 et donnez-lui le nom dir23.
mv ~/test/dir1 ~/test/dir2/dir23
# 5 correction
mv dir1 dir2/dir23
tree

# 6. Renommez les répertories dir11 et dir12 respectivement en dir231 et dir232.
mv ~/test/dir2/dir23/dir11 ~/test/dir2/dir23/dir231
mv ~/test/dir2/dir23/dir11 ~/test/dir2/dir23/dir232
# 6 correction
cd dir2/dir23
mv dir11 dir231
mv dir12 dir232
tree ../..

# 7. Revenez au somme de votre arborescence (~/test).
cd ~/test/
pwd

######## FICHIERS: #######
# 1. Vous devez vous trouver dans ~/test.
cd ~/test
pwd
# 2. Créez un fichier vide dans le répertoire courant et appelez-le fich0.
touch fich0
# 3. Copiez le fichier /etc/passwd dans le répertoire courant en le nommant fich1.
cp /etc/passwd fich1
# 4. Copiez le fichier /etc/group dans le répertoire courant en le nommant fich2.
cp /etc/group fich2
# 5. Copiez le fichier /etc/os-release dans le répertoire courant sans le renommer.
cd /etc/os-release .
# 6. Redirigez le résultat de la commande dmesg dans le fichier fich3.
sudo dmesg > fich3
# 7. Affichez le contenu du répertoire courant de manière à avoir la taille de chaque fichier.
ls -l
# 8. Affichez les nombre de caractères de fich1.
wc -m fich1
# 9. Affichez les nombre de lignes de fich2.
wc -l fich2
# 10. Affichez les nombre de mots de fich3.
wc -w fich3
# 11. Affichez les nombre de lignes, de mots et de caractères de os-release.
wc os-release
# 12. Affichez le contenu du fichier os-release à l’écran.
cat os-release

# 13. Affichez les trois première lignes du fichier fich3.
head --lines=3 fich3
# 13 correction
head -3 fich3

# 14. Affichez les 12 dernières lignes du fichier fich3.
tail --lines=12 fich3
# 14 correction
tail -12 fich3

# 15. Affichez le nombre de mots contenus dans les 8 dernières lignes du fichier fich3.
tail --lines=8 fich3 | wc -w
# 15 correction
tail -8 fich3 | wc -w

# 16. Redirigez les 4 premières lignes et les 2 dernières lignes du fichier fich2, 
# triées en ordre décroissant vers le fichier fich4 (sans créer de fichier temporaire).
head --lines=4 fich2 > fich4 ; tail --lines=2 fich2 >> fich4 ; cat fich4 | sort -d
# 16 correction
(head -4 fich2 ; tail -2 fich2) | sort -r > fich4
cat fich4

# 17. Afficher le contenu de fich1 dans l’ordre inverse.
tac fich1

# 18. Déplacez le fichier fich1 dans le répertoire dir22.
mv fich1 ~/test/dir2/dir22
# 18 correction
mv fich1 dir2/dir22

# 19. Déplacez le fichier fich2 dans le répertoire dir231.
mv fich2 ~/test/dir2/dir22/dir231
# 19 correction
mv fich2 dir2/dir22/dir231

# 20. Déplacez le fichier fich3 dans le répertoire dir2.
mv fich3 ./dir2/
# 20 correction
mv fich3 dir2/

# 21. Affichez l’arborescence à partir de ~/test.
tree ~/test
# 21 correction
tree .

######## RECHERCHE #######
#
# 1. Vous devez vous trouver dans ~/test.
cd ~/test
pwd

# 2. Créez une série de fichiers avec des noms divers. 
touch aze.txt abs.txt s0er e1f lea 0e2 123 sdfe lqsd3 21e 13ef3 1feq.txt 32fe3
ls

# Listez les fichiers avec les caractéristiques suivantes :
# — Les fichiers ayant une extension .txt.
find ~ -type f -name "*.txt"

# correction
ls *.txt

# — Les fichiers commençant par une lettre puis un chiffre.
find ~ -type f -name "[a-zA-Z][0-9]*"
# correction
ls [a-zA-Z][0-9]*

# — Les fichiers dont le nom possèdent uniquement trois caractères. 
find ~ -type f -name "???"
# correction
ls ???

# — Les fichiers dont les noms contiennent un a ou un b.
find ~ -type f -name "[ab]*"
# correction
ls *[ab]*

# — Les fichiers qui ne commencent pas par un chiffre.
find ~ -type f -name "[^0-9]*"
# correction
ls [^0-9]

# 3. Recherchez dans l’historique des commandes toutes les fois où vous avez utilisé ls, et affichez- les.
histoye | grep "ls"
# correction
history | grep ls

# 4. Un de vos collègues vous donne un disque dur et vous demande de copier dans votre répertoire dir21 
# toutes les photos s’y trouvant. Donnez la commande permettant de réaliser cette opération.
find / -iname "*.jpg" -type f -exec cp {} ~/test/dir2/dir21
# correction
find /media/hdd -type f -name "*jpg" -exec cp "{}" dir2/dir21 \;

# 5. Listez le contenu du répertoire info se trouvant dans le répertoire courant. 
# Si le répertoire n’existe pas, créez-le, ajoutez-y un fichier appelé dmesg.log avec comme contenu 
# le résultat de la commande dmesg et affichez le contenu du répertoire.
ls info || (mkdir && touch ./info/dmesg.log && sudo dmesg > ./info/dmesg.log && ls info)
# correction
ls info 2>/dev/null || ( mkdir info && sudo dmesg > info/dmesg.log && ls info )

# 6. Listez tous les répertoires auxquels vous n’avez pas accès dans un fichier no_access.log.
find / -type d 2>&1>/dev/null 2>no_access.log
# correction
find / -type d 2>no_acces.log >/dev/null
head -4 no_access.log

# 7. Vous être en train de développer une application importante. Dans les commentaires du code, 
# vous avez ajouté des « TODO » indiquant ce qui reste à faire. 
# Parcourez tous vos fichiers source pour afficher ces commentaires.
grep -r "TODO" ~
# correction
find . -type f -name "*.py" -exec grep -i todo "{}" -Hn -C 2 --color \;

# 8. Combien de comptes d’utilisateur peuvent-t-ils être utiliser pour s’identifier sur votre machine ?
cat /etc/passwd | wc -l
# correction
grep -f /etc/shells /etc/password | wc -l

# 9. Recherchez tous les fichiers se trouvant dans le répertoire courant et les sous-répertoires et supprimez-les.
find . -type f -exec rm {}
# correction
find -type f delete

# 10. Supprimez tous les répertoires se trouvant dans le répertoire courant.
find . -type f -exec rmdir {}
# correction
find -type d delete