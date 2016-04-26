#!/bin/bash
#Usage ./clean_preprocess_create_train_val.sh input_dir_with_imgs output_dir CAFFE_ROOT_DIR
IN_DIR=$1
OUT_DIR=$2
CAFFE_ROOT=$3
mkdir -p $OUT_DIR
echo 'Copying dataset'
cp -r ${IN_DIR}/* ${OUT_DIR}/
echo './remove_spaces_in_fnames.sh' $OUT_DIR
./remove_spaces_in_fnames.sh $OUT_DIR
echo './rm_files_size_less_2K.sh' $OUT_DIR
./rm_files_size_less_2K.sh $OUT_DIR
echo './rename_fake_jpeg_to_png.sh' $OUT_DIR
./rename_fake_jpeg_to_png.sh $OUT_DIR
echo './remove_duplicate_imgs_from_dir.sh' $OUT_DIR jpg
./remove_duplicate_imgs_from_dir.sh $OUT_DIR jpg
echo './resize_to_256xN_inplace.sh' $OUT_DIR
./resize_to_256xN_inplace.sh $OUT_DIR
echo './create_train_val_lmdbs.sh' $OUT_DIR $CAFFE_ROOT
./create_train_val_lmdbs.sh $OUT_DIR $CAFFE_ROOT
