#!/bin/bash

sn=$(basename $0)
usage="Usage: '$sn'"

# check le nombre de parametre
if [[ $# -lt 1 || $# -gt 2 ]] ; then
    echo "$usage PROCESSNAME [DELAY]"
    exit 1
fi

