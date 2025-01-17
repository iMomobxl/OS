#!/bin/bash

#######################
######## ex_999 #######
### count.sh script ###
#######################

sn=$(basename $0)
# check si je suis root
if [[ $EUID -ne 0 ]] ; then
    echo "You must be root to execute this script"
    exit 1
fi

# check the number of param
if [[ $# -lt 2 ]] ; then
    echo "Usage: $sn: Minimum 2 parameter must be provide"
    exit 2
fi

# check the first param
if [[ $1 != '-c' && $1 != '-d' ]] ; then
    echo "Usage: $sn: Wrong parameter, must be -c or -d"
    exit 3
fi

# check if the user exist
param_user=$2
user=$(id -g $param_user) 2>/dev/null

if [[ $? -ne 0 ]] ; then
    echo "$sn: users doesn't exist"
    exit 4
fi

path=/home/$param_user/count

if [[ $1 = "-c" ]] ; then
    #echo "Hello World!" > $path
    nbr_lines=0
    nbr_words=0
    for elem in ${@:3}; do
        # check if the param is file
        if [[ ! -f "$elem" ]] ; then
            echo "Usage: $sn: this '$elem' is not a file or doesn't exist"
            exit 7
        fi
        elem_lines=$(wc -l < $elem)
        elem_word=$(wc -w < $elem)
        echo "lines: $elem_lines"
        echo "words: $elem_word"
        nbr_lines=$(($nbr_lines + $elem_lines))
        nbr_words=$(($nbr_words + $elem_words))
    done
    echo $nbr_lines > $path
    echo $nbr_words >> $path
    echo "Resultat:"
    cat $path
## else param = -d
else
    # check if count file exist
    if [[ ! -f "$path" ]] ; then
        echo "$sn: count file doesn't exist"
        exit 5
    fi
    rm "$path"
    if [[ $? -ne 0 ]] ; then
        echo "$sn: error on delete count file"
        exit 6
    fi
    echo "$sn: the count has been deleted"
fi

exit 0
