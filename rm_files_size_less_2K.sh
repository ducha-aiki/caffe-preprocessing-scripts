#!/bin/bash
#Usage ./rm_files_size_less_2K.sh dir_to_apply
find $1 -name "*" -size -2k -delete