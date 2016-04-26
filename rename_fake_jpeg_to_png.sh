#!/bin/bash
#Usage: ./rename_jpeg_to_png.sh path_to_dir
#Renames jpeg which are really PNG to the real extension
find $1/ -name *.jpg -exec file {} \; | grep PNG | sed -e s/:.*// | rename s/.jpg/.png/