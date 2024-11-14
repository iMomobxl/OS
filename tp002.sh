#!/bin/bash

#######################
######## tp02 #########
## Ali Bacha Mohamed ##
#######################

#!/bin/bash

### Répertoires, fichiers et recherches
#
# 1. Vous devez vous trouver dans le répertoire ~/test.
cd ~/test

# 2. Créer un fichier months contenant le calendrier du mois courant avec un mois avant et un mois après. 
# Afficher le contenu de ce fichier.
cal -3  > month ; cat month

# 3. Afficher les éléments cachés (dont le nom commence par un point) dans le répertoire personnel de l’utilisateur courant.
ls -a /home/users/
ls -a ~
ls -a .. #si on se trouve dans le dossier /test/

# 4. 
# Créer 3 fichiers commençant par essai et dont seulement l’un d’entre eux contient le mot « Bonjour ». 
# Créer 3 fichiers commençant par ESSAI et dont seulement l’un d’entre eux contient le mot « bonjour » (attention à la case). 
# Afficher la liste des fichiers dont le nom commence par « ess » (insensible à la case) qui contiennent le « bonjour » (insensible à la case).
touch essai{1,2,3} ; echo "Bonjour" > essai1
touch ESSAI{1,2,3} ; echo "bonjour" > ESSAI1
find . -type f -iname "ess*" -exec grep -i bonjour "{}" \;

# 5. Combien de systèmes de fichiers sont-il montés ?
mount | wc -l

# 6. Afficher au format long la liste des liens (et uniquement eux) se trouvant directement à la racine de l’arborescence.
find / -type l -ls

# 7. Vous avez une série de fichiers PDF. Le nom de ces fichiers a la forme « XXXXXXX_LL.pdf », 
# avec XXXXXXX le nom du fichier et LL le code de langue du fichier (par exemple « fr » pour le français). 
# Au moyen d’une commande, supprimez tous les fichiers PDF qui ne sont pas en français.
find /home/user -type f -iname "*[^FR].pdf" delete

# 8. Rediriger le résultat de la commande sudo journalctl --no-pager vers le fichier journal. Quelle est la taille du fichier ?
ls -lh #2,6M

# 9. Sur base du contenu du fichier journal, combien de fois la machine virtuelle a-t-elle démarrée?
# --Boot
grep "\-\- Boot" journal | wc -l

# 10. Sur base du contenu du fichier journal, lister toutes les sessions SSH qui ont été ouvertes.
# ssh et session opened
grep 'ssh' journal | grep 'session opened'

# 11. Sur base du contenu du fichier journal, lister toutes les fois où l’utilisateur s’est trompé de mot de passe lors d’une connexion SSH.
# ssh et failed password
grep 'ssh' journal | grep 'failed password'

### 3 Répertoires, fichiers et recherches (2)
#
# Enoncé
# 
# 1. Afficher le contenu du répertoire exserie002 au format long.
cd ~/test/exserie002
ls -lh

# 2. Afficher l’arborescence du répertoire exserie002 avec la taille de chaque élément.
tree -h

# 3. Créer un fichier data.lst qui contiendra la liste de tous les fichiers data (avec l’extension .dat). 
# Afficher ensuite le contenu de ce fichier.
find . -type f -iname "*.dat" > data.lst ; cat data.lst

# 4. Lister tous les fichiers binaires (avec l’extension .bin) avec leur taille.
find . -type f -iname "*.bin" -ls

# 5. Combien y a-t-il de fichiers texte (avec l’extension .txt) ?
find . -type f -iname "*.txt" | wc -l

# 6. Combien y a-t-il de mots dans l’ensemble des fichiers texte (avec l’extension .txt) ?
find . -type f -iname "*.txt" -exec cat "{}" + | wc -w

# 7. Combien y a-t-il de mots différents dans l’ensemble des fichiers texte (avec l’extension .txt) ?
# de caractères dans l’ensemble des fichiers data (avec l’extension .dat) ?
find . -type f -iname "*.txt" -exec cat "{}" + | tr " " "\n" | sort | uniq | wc -w
find . -type f -iname "*.dat" -exec cat "{}" + | wc -m

# 8. Combien y a-t-il de répertoire d’au moins 6 caractères ?
find . -type d -name ??????

# 9. Combien y a-t-il de fichiers texte contenant la séquence de caractères cert ?
find . -type f -iname "*.txt" -exec grep "cert" "{}" + | wc -l

# 10. Combien y a-t-il de fichiers texte contenant sur la même ligne la séquence de caractères cert,


# 11. Combien y a-t-il de fichiers texte contenant sur la même ligne la séquence de caractères cert, mais pas elle ?
find . -type f -iname "*.txt" -exec grep "cert" "{}" + | grep -v "elle" | wc -l

# 12. Exécuter les actions suivantes :
# (a) Créer un répertoire « big_files ».
mkdir big_files

# (b) Dans un fichier log, enregistrer la date courante.
date > log

# (c) Dans ce même fichier log, enregistrer la phrase « Copie des gros fichiers en cours ».
echo "Copie des gros fichiers en cours" >> log

# (d) Copier tous les fichiers de plus de 12Mb se trouvant dans les sous-répertoires de exserie002 dans le répertoire big_files.
find . -size +12M -type f -exec cp "{}" ./big_files/ \;

# (e) Dans le fichier log, enregistrer la date courante.
date >> log

# (f) Lister ensuite le contenu du répertoire avec la taille des fichiers.
ls -lh

# (g) Afficher le contenu du fichier log.
cat log

# Combien de temps a pris la copie des gros fichiers ?
# 0 car pas de fichier plus de 12Mb

# 13. Afficher la taille du contenu des répertoires se trouvant directement sous exserie002 en kilo-octets, classé dans l’ordre décroissant de taille.
ls -lhS