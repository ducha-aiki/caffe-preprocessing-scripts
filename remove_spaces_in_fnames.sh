#!/bin/bash
#Usage ./remove_spaces_in_fnames.sh dir_to_apply
find $1 -depth -name "* *" -execdir rename -f 's/ /_/g' "{}" \;