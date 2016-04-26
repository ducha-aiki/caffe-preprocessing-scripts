#!/bin/bash
#usage: resize_to_256xN_inplace.sh input_dir
DIR=$1
FILES=`find $1/ -maxdepth 5 -name "*.*"` # Base find command
for f in $FILES
do
  if [ -f $f ]; then
   mogrify -resize "256x256^" $f
  fi
done