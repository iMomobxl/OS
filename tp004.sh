#!/bin/bash

#######################
######## tp04 #########
## Ali Bacha Mohamed ##
#######################
# script supplementaire:
# askname.sh
# groups.sh
# helloworld.sh
# infinite.sh
# install_script.sh



# 2 Éditeur en mode texte
#
# Les exercices suivants doivent être réalisés avec vi :
cd ~/test
# 1. Créez un fichier texte avec une dizaine de lignes et contenant plusieurs fois le mot « hello ».
touch hello.txt
vi hello.txt

# my output:
# user@OS:~/test$ cat hello.txt
# hello world!
# hello a hello b
# blablabla hello 
# why you didn't tell me hello
# goodbye hello
# hello
# create a fill with 10 line include hello
# this line doesn't have hello
# that one has hello and maybe two hello
# hello, that is the last line 

# 2. Remplacez toutes les occurrences du mot « hello » par « salut » sur la ligne courante.
vi hello.txt
/motif

# repeter pour chaques ligne
:s/motif/salut/g
n

# ou remplace tout en une seul instruction
:%s/hello/salut/g # remplace tout en une seul instruction

# my output
# user@OS:~/test$ cat hello.txt
# salut world!
# salut a salut b
# blablabla salut 
# why you didn't tell me salut
# goodbye salut
# salut
# create a fill with 10 line include salut
# this line doesn't have salut
# that one has salut and maybe two salut
# salut, that is the last line 

# 3. Remplacez toutes les occurrences du mot « hello » par « bonjour » dans tout le texte.
# idem question 2.

# 4. Recopiez 25 fois les 3 prochaines lignes.
# 3yy
# 25P

# 5. Supprimez les 5 mots suivants.
# 5dw

# 6. Supprimez les 6 prochaines lignes.
# 6dd

# 7. Annulez la dernière suppression.
# u

# 8. Vous avez créé une commande iplookup qui prend une ou plusieurs adresse IP en entrée et
# donne différentes informations à son propos. Créez un fichier readme qui explique comment uti-
# liser la commande. Vous pouvez vous inspirer des pages du man. Imaginez les différents options
# et paramètres à votre guise.
touch readme
vi readme

# 9. Votre commande évolue et maintenant accepte des noms de domaine. Modifiez le fichier readme
# créé précédemment pour renommer iplookup en addrresolv.
vi readme

# 3 Introduction aux scripts
#
# 1. Créez un script affichant « Hello world! ».
mkdir ./script/
touch ./script/helloworld.sh
vi ./script/helloworld.sh
chmod u+x ./script/helloworld.sh
cd script
./helloworld.sh
# output:
# user@OS:~/test/script$ ./helloworld.sh 
# Hello World!

# 2. Créez un script qui demande son nom à l’utilisateur et affiche 25 fois (sans utiliser de boucle)
# « Salut <nom> ».
touch askname.sh
vi skname.sh
chmod u+x askname.sh
./askname.sh

# 3. Créez un script infinite.sh avec une boucle infinie (voir les slides).
touch infinite.sh
vi infinite.sh
chmod u+x infinite.sh
./infinite.sh

# 4. Gestion des processus
#
# 1. Parmi tous les processus, retrouvez ceux qui sont exécutés en tant que root.
ps --User root
# correction 
ps -U root -u root u

# 2. Parmi tous les processus, retrouvez ceux qui sont exécutés avec le compte de l’utilisateur courant.
ps --user user
# correction
cu=$(whoami) && ps -u $cu -U $cu u

# 3. Exécutez en arrière-plan et sans paramètre la commande cat. Envoyez-lui ensuite un signal pour l’arrêter.
cat
bg
ps u
kill -9 1385 # 1385 = id du jobs
# correction
cat &
jobs
kill 1042
jobs
kill -9 1042


# 4. Dans un premier terminal, exécutez en arrière-plan 3 instances de infinite.sh. 
# Dans un second, exécutez la commande top de manière à voir apparaître vos scripts. 
# Dans un troisième terminal, envoyez des signaux aux différentes instances de votre script pour les arrêter. 
# Vous devriez les voir disparaître dans le second terminal.

# Terminal 1 ### Terminal 2 ### Terminal 3 ###
# cat        ### top        ### kill -9 <id>
# bg         ###            ### kill -10 <id>
# cat        ###            ### kill -11 <id>
# bg
# cat
# bg

# correction
# terminal 1:
./infinite.sh & # & = excute directement la commande en arriere plan, remplace bg + ^z
./infinite.sh &
./infinite.sh &
# terminal 2:
top -u $(whoami)
# termial 3:
kill 1089
kill 1090
kill 1091

# 5 Scripts
#
# 1. Réalisez un script appelé groups.sh qui, sur base du contenu du fichier /etc/group, retrouve le
# nom de tous le groupes dont vous faites parties (le résultat doit être identique à la commande groups).
# Assurez-vous que le nombre des paramètres soit correct et que l’utilisateur donné existe.
pwd
cd ~/test/script
touch groups.sh
vi groups.sh
chmod u+x groups.sh
./groups.sh

# output:
# user@OS:~/test/script$ ./groups.sh
# cdrom floppy sudo audio dip video plugdev users netdev user 
# user@OS:~/test/script$ groups 
# user cdrom floppy sudo audio dip video plugdev users netdev
# user@OS:~/test/script$ 

# 2. Réalisez un script appelé install_script.sh qui va permettre d’installer un script sur votre système. 
# Le script va prendre les paramètres suivants :
#
# - SCRIPT (obligatoire) Le script à installer.
# - INSTALLDIR (facultatif) Le répertoire où le script sera installé. S’il n’est pas donné le répertoire
# de destination sera /opt/perso_scripts
# - Une fois que le script à installer sera copié dans le répertoire de destination, 
# un lien symbolique sera créé dans /usr/local/bin avec le nom du script sans extension. 
# Par exemple, si vous installer install_script.sh, vous aurez un lien symbolique /usr/local/bin/install_script
# qui pointera vers /opt/perso_scripts/install_script.sh.
# Assurez-vous d’avoir les droits nécessaires pour exécuter le script, et que le nombre des paramètres soit correct. 
# Assurez-vous également que le répertoire de destination existe (sinon créez-le) et que le script installé possède les bonnes permissions.
touch install_script.sh
chmod u+x groups.sh
vi install_script.sh


# 3. Exécutez le script install_script.sh sur lui-même.

# 4. Installez le script infinite.sh sur votre ordinateur.