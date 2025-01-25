#!/bin/bash

$sn=&(basename $0)
if [[ $# -ne 1 ]] ; then   
    echo "Usage: $sn FILENAME"
    exit 1
fi

$filename=$1

if [[ ! -f "$filename"]] ; then
    echo "$sn: '$filename' n'est pas un fichier"
    exit 2
fi

if [[ -s "$filename" ]] ; then
    trash_dir="$(dirname $filename)"/.trash
    [[ -d "$trash_dir" ]] || mkdir "$filename"
    mv "$filename" "$trash_dir"
else
    rm "$filename"
fi


