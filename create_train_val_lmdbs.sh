#!/bin/bash
CLASSES_DIR=$1/*
CAFFE_ROOT_DIR=$2
conv=$CAFFE_ROOT_DIR/build/tools/convert_imageset

mkdir -p lmdb
class=0
for f in $CLASSES_DIR
do
  if [ -d "$f" ]; then
    echo "Processing $f dir..."
    find `pwd`/${f} -type f -exec echo {} \; > ${f}.txt
    sed "s/$/ ${class}/" ${f}.txt > ${f}_list.txt
    cat ${f}_list.txt >> full_list.txt
    echo $f $class >> classes_list.txt
    let class=class+1
    rm ${f}.txt
    rm ${f}_list.txt
  fi
done
shuf full_list.txt > full_train_list.txt
split -n l/9 --numeric-suffixes=1 --suffix-length=1 full_train_list.txt small
i=0
for f in `find . -name "small*"`; 
do 
if [[ "$i" == 0 ]]; 
then mv $f test_list.txt
i=1
else
cat $f >> train_list.txt
fi; 
done 
rm -rf train_lmdb
rm -rf test_lmdb
$conv --backend=lmdb --encoded=true '' train_list.txt train_lmdb
$conv --backend=lmdb --encoded=true '' test_list.txt test_lmdb
rm small*
rm full_train_list.txt
