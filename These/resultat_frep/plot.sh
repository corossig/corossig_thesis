#!/bin/sh

for i in *.plot
do
    dest="${i%.*}.svg"
    if [ ! -e "$dest" ] || [ "$dest" -ot "$i" ] || [ $# -gt 0 ]
    then
        NB_COL=$(head -n 3 "${i}" | tail -n 1 | wc -w)
        YRANGE=12
        case "$i" in
            *_spmv_*)
                YRANGE=0.3
                LOGSCALE="set logscale x 2"
                XLABEL='set xlabel "Nombre de répétitions"'
                ;;
            *_trsv_*)
                YRANGE=8
                LOGSCALE=""
                XLABEL='set xlabel "Nombre de répétitions du GMRES"'
                ;;
            *_facto_*)
                YRANGE=1
                LOGSCALE=""
                XLABEL='set xlabel "Nombre de répétitions du GMRES"'
                ;;
        esac
        
        gnuplot -p << EOF
$XLABEL
set ylabel "Temps d'exécution moyen (s)"
set key left top noreverse
set yrange [0:$YRANGE]
$LOGSCALE
set terminal svg size 700,500 fname 'Verdana' fsize 16
set output "$dest"
plot for [i=2:${NB_COL}] "${i}" u 1:i title column(i) w lp
EOF
    fi
done
