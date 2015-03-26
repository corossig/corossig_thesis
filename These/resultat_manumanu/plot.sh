#!/bin/sh

for i in *.plot
do
    dest="${i%.*}.svg"
    if [ ! -e "$dest" ] || [ "$dest" -ot "$i" ] || [ $# -gt 0 ]
    then
        NB_COL=$(head -n 3 "${i}" | tail -n 1 | wc -w)
        YRANGE=12
        KEY="right"
        case "$i" in
            *_mpi_*)
                KEY="left"
                YRANGE=120
		;;
            *_facto_*)
                YRANGE=17
                ;;
            *_trsv_*)
                YRANGE=10
		;;
            *_spmv_nas_*)
                YRANGE=60
                ;;
            *_spmv_*)
                YRANGE=14
                ;;
        esac
        
        gnuplot -p << EOF
set xlabel "Nombre de threads"
set ylabel "Accélération"
set key $KEY top noreverse
set yrange [0:$YRANGE]
set terminal svg size 700,500 fname 'Verdana' fsize 16
set output "$dest"
plot for [i=2:${NB_COL}] "${i}" u 1:i title column(i) w lp
EOF
    fi
done
