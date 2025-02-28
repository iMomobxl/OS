#!/bin/bash

sn=$(basename $0)
usage="Usage: '$sn'"

# check le nombre de parametre
if [[ $# -lt 1 || $# -gt 2 ]] ; then
    echo "$usage PROCESSNAME [INTERVAL]"
    exit 1
fi

name=$1
interval=$2

# check le deuxieme parametre est un nombre
regex='^[0-9]+$'

if [[ -z $interval ]] ; then
    interval=300
elif [[ ! $interval =~ $regex ]] ; then
    echo "'$interval' n'est pas nombre valide, interval definit par defaut a '5min'"
    interval=300
fi

while : ; do
    process=$(ps aux | tr -s " " | tr " " "-" | grep -i $name | head -n 1)
    if [[ -n $process ]] ; then
        process_pid=$(echo "$process" | cut -d - -f 2)
        process_user=$(echo "$process" | cut -d - -f 1)
        process_mem=$(echo "$process" | cut -d - -f 3)
        process_cpu=$(echo "$process" | cut -d - -f 4)
        process_cmd=$(echo "$process" | cut -d - -f 11)
        echo -n "PID: $process_pid, "
        echo -n "USER: $process_user, "
        echo -n "MEM: $process_mem, "
        echo -n "CPU: $process_cpu, "
        echo "COMMAND: $process_cmd"
    else
        echo "Erreur: processus '$name' pas ete trouvé ou est a l'arret"
        exit 2
    fi
    sleep $interval
done