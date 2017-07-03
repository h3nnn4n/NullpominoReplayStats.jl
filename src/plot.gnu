#!/usr/bin/gnuplot

reset

#set terminal pngcairo size 1600,600 enhanced font 'Verdana,9'
#set terminal pngcairo size 650,220 enhanced dashed font 'Verdana,10'
set terminal pngcairo size 1650,600 enhanced dashed font 'Verdana,10'
set output 'time.png'

set style line 11 lc rgb '#808080' lt 1
set border 3 front ls 11
set tics nomirror

set style line 12 lc rgb'#808080' lt 0 lw 1
set grid back ls 12

#show style lines

#Colorful
set style line 1 lw 1 lt 1 lc rgb '#1B9E77' # dark teal
set style line 2 lw 1 lt 1 lc rgb '#D95F02' # dark orange
set style line 3 lw 1 lt 1 lc rgb '#7570B3' # dark lilac
set style line 4 lw 1 lt 1 lc rgb '#E7298A' # dark magenta
set style line 5 lw 1 lt 1 lc rgb '#66A61E' # dark lime green
set style line 6 lw 1 lt 1 lc rgb '#E6AB02' # dark banana
set style line 7 lw 1 lt 1 lc rgb '#A6761D' # dark tan
set style line 8 lw 1 lt 1 lc rgb '#666666' # dark gray

set key bottom right

#set key samplen 4

set xlabel 'Number of games'
set ylabel 'Time (s)'

#set yrange [0:]
set yrange [0:]

set xtics rotate by -55

#set xdata time
#set timefmt '%Y-%m-%d-%H:%M:%S'

#set boxwidth 0.5
#set style fill solid

plot \
'log'      u (column(0)):2 notitle w l ls 1, \
#'log'      u (column(0)):4 notitle w l ls 1, \
#'log'      u (column(0)):3 notitle w l ls 1, \
#'log'      u 1:2 notitle w boxes ls 1, \
