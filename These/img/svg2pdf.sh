#!/bin/sh

for src in *.svg
do
    case $src in
        r_*)
            dest="${src#r_}"
            dest="${dest%%.*}.png"
            options="-d 180 -e"
            ;;
        *)
            dest="${src%%.*}.pdf"
            options="-A"
            ;;
    esac
    
    if [ ! -e "$dest" ] || [ "$dest" -ot "$src" ] || [ $# -gt 0 ]
    then
        echo processing $src to $dest
        inkscape -f "$src" ${options} "$dest"
    fi
done
