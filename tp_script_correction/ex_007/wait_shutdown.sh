#!/bin/bash

sn=$(basename $0)
grace_delay=5

if [[ $EUID -ne 0 ]] ; then
    echo "$sn: vous devez etre root!"
    exit 1
fi

if [[ $# -lt 1 || $# -gt 2 ]] ; then
    echo "Usage: '$sn' PROCESSNAME [DELAY]"
    exit 2
fi

process_name=$1
delay=${2:--1}

wait_start=$( date + "%s" )
stop_sent=false
stop_forced=false

# ps h -o pid -C vi
while : ; do
    pids=$(ps h -o pid -C $process_name)
    if [[ -z $pids ]] ; then
        break
    fi
    if [[ $delay -gt 0 ]] ; then
        current_time=$(date + "%s")
        deadline=$(( wait_start + $delay ))
        if [[ $current_time -gt $deadline ]] ; then
            if [[ $stop_send = true ]] ; then
                deadline=$(( $deadline + $grace_delay ))
                if [[ $current_time -gt $deadline ]] ; then
                    kill -9 $pids
                    stop_forced=true
                fi
            else
                kill $pids
                stop_sent=true
            fi
        fi
    fi  
    sleep 1
done

username=$( who am i | cut -d ' ' -f 1)
homer_dir=$(grep "^$username:" /etc/passwd | cut -d ' ' -f 6)
#home_dir=/home/$username (pas recommandé
logfile=$home_dir/shutdown.log
if [[ $stop_forced = true ]] ; then
    echo "Processus '$process_name' arrete de maniere force" >> $logfile
elif [[ $stop_sent = true ]] ; then
    echo "Processus '$process_name' arrete" >> $logfile
else
    echo "Processus '$process_name' arrete de lui meme" >> $logfile
fi
echo "Machine arrete a $(date)"
poweroff
