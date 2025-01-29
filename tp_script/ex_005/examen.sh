#!/bin/bash

sn=$(basename $0)

# check if root
if [[ $EUID -ne 0 ]] ; then
    echo "$sn: Vous devez etre root"
    exit 1
fi