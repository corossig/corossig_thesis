#!/bin/sh

for i in *.plot
do
    NB_COL=$(head -n 3 "${i}" | tail -n 1 | wc -w)
    gnuplot -p << EOF
set xlabel "Nombre de threads"
set ylabel "Speedup"
set key left top noreverse width 2
set yrange [0:10]
set terminal svg size 700,500 fname 'Verdana' fsize 16
set output "${i%.*}.svg"
plot for [i=2:${NB_COL}] "${i}" u 1:i title column(i) w lp
EOF
done
