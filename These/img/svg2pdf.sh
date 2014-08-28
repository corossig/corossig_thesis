#!/bin/sh

for src in *.svg
do
    dest="${src%%.*}.pdf"
    if [ ! -e "$dest" ] || [ "$dest" -ot "$src" ] || [ $# -gt 0 ]
    then
        echo processing $src to $dest
        inkscape -f "$src" -A "$dest"
    fi
done
