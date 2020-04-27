#!/bin/gnuplot -persist
set output "D1_plot.png"
set title "Ping Diagram" font ",14" textcolor rgbcolor "royalblue"
set xlabel "Time"
set ylabel "packet Drop"
set pointsize 1
plot "<awk '{print $2,$1}' file.txt" with lines
