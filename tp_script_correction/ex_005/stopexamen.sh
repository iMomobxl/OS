#!/bin/bash

if [[ $EUID -ne 0 ]] ; then
    echo "Vous devez etre root"
    exit 1
fi

chmod -R a-w /examen
chown -R root /examen