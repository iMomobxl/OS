#!/bin/bash

sn=$(basename $0)

if [[ $# -ne 1 ]] ; then
    echo "Usage: $sn [SCRIPT]]"
    exit 1
fi

script=$1

if [[ -e "$script" ]] ; then
    echo "$sn: '$script' existe deja"
    exit 2
fi

echo "#!/bin/bach" > "$script"
echo >> "$script"
echo >> "$script"

chmod a+x "$script"

