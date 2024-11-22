#!/bin/bash

#######################
######## tp03 #########
## ................. ##
#######################

### Gestion des accès
#
# 1. Donnez les noms d’utilisateur des comptes qui peuvent se connecter sur le système.
( grep -f /etc/shells /etc/passwd ) | cut -d : -f 1 | tr "\n" " "

# 2. Sur base du contenu du fichier /etc/group, retrouvez le nom de tous le groupes dont vous faites parties 
# (le résultat doit être équivalant à la commande groups)
cat /etc/group | grep user | cut -d : -f 1 | tr "\n" " "

# 3. Le responsable R&D de votre entreprise vient vous trouver. Un nouveau projet de robotique vient
# de démarrer et il voudrait que ses équipes puissent collaborer. Il y a les équipes « énergie »,
# « mécanique », « électronique » et « software ». Chaque équipe doit avoir son propre répertoire
# accessible en lecture uniquement aux autres équipes. Aussi, chaque équipe doit avoir un espace
# restreint accessible uniquement aux membres de l’équipe où seront stockées les données non
# encore validées
# Voici les différentes étapes pour résoudre l’exercice, donner les commandes correspondantes :
# (a) créer les groupes de chaque équipe;

# (b) créer les utilisateurs et les placez dans ces groupes en fonction de leur équipe;

# (c) créer le répertoire /projet avec les permissions adéquates;

# (d) dans /projet, créer un répertoire par équipe avec les permissions adéquates;

# (e) dans chaque répertoire d’équipe, créer un répertoire restricted accessible uniquement à l’équipe;

# Afin de valider votre solution, identifiez-vous avec des utilisateurs de différentes équipes 
# et essayez de différentes opérations sur les dossiers et les répertoires.

# Ce sont les examens à l’EPHEC. Vous gérez le serveur sur lequel les étudiants déposeront leurs
# travaux. Créez un répertoire pour chaque étudiant dans le répertoire /examephec. Les étudiants
# ne pourront pas voir le contenu de ce dernier, mais pourront accéder à leur propre répertoire,
# et uniquement ce dernier. Les professeurs, quant à eux, pourront voir le contenu de tous les
# répertoires de tous les étudiants, ainsi que le contenu de examephec.
# Voici les différentes étapes pour résoudre l’exercice, donner les commandes correspondantes 
# (a) créer le groupe examephec;

# (b) créer un compte enseignant et le placer dans le(s) groupe(s) approprié(s);

# (c) créer des comptes étudiants et les placer dans le(s) groupe(s) approprié(s);

# (d) créer le répertoire /examephec avec les permissions appropriées;

# (e) dans /examephec, créer les répertoires des étudiants avec les permissions appropriées;

# Afin de valider votre solution, identifiez-vous avec des comptes étudiants et le compte enseignant,
# et essayez de différentes opérations sur les dossiers et les répertoires.

# 5. Les examens sont finis. Quelle(s) commande(s) devez-vous utiliser pour que les étudiants ne
# puissent plus rien modifier dans leurs répertoires.