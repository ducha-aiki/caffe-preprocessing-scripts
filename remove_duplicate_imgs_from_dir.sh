#!/bin/bash
DATE=`date +%Y-%m-%d_%s%N`
CURR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DIR_NAME=$1
EXT=$2
LIST_FILE=/tmp/${DIR_NAME}_${DATE}
LIST_FILE_sorted=${LIST_FILE}_sorted
tt=${DATE}_tt

#identify -format "%# %f\n" ${DIR_NAME}/*.${EXT} > $LIST_FILE

for f in `find ${DIR_NAME} -name "*.${EXT}"`; do
identify -format "%# %f\n" $f >> $LIST_FILE
done

sed '/^$/d' $LIST_FILE > ${tt}
mv $tt $LIST_FILE
sort $LIST_FILE> $LIST_FILE_sorted
export DN=$DIR_NAME/
awk '{if($1 in name) {print ENVIRON["DN"] $2 }; name[$1]=$2;next} ' $LIST_FILE_sorted | xargs rm
