#/usr/bin/bash

if [ $# -eq 1 ]; then
    ffmpeg -i "$1" -c:a alac "/home/miyu/${1%.*}.m4a"
elif [ $# -eq 2 ]; then
    ffmpeg -i "$1" -i "$2" -c:a alac -c:v:0 png -disposition:v:0 attached_pic "${1%.*}.m4a"
else
    >&2 echo "Usage: to_alac.sh <input> [cover]"
    exit 1
fi
