reset
# set terminal qt
# set terminal cairolatex pdf lw 2 fontscale 0.5 size 7cm,5cm
set terminal pdfcairo font "Fira Code,9" fontscale 0.5 rounded size 7cm,4cm

# set lmargin explicitly to line up plotting areas
set margin 0
set bmargin at screen 0.2
set tmargin at screen 0.85

load "moreland.pal"

# set xlabel "x"
# set grid back
# # set size ratio 0.75
# set zeroaxis lt -1 lc "dark-grey"
# set key opaque

set output "quadratic.pdf"
# set pm3d interpolate 1,1 flush begin noftriangles border lt black linewidth 1.000 dashtype solid corners2color mean
# set pm3d lighting primary 0.5 specular 0.5 spec2 0
# unset colorbox
set xrange [-5:5]
set yrange [-5:5]
set zrange [0:50]
set isosamples 20
set contour
set cntrparam levels discrete 2,5,10
set cntrlabel onecolor
unset key
set hidden3d
set view 79,26
set grid
set zeroaxis
set xyplane at -10
set xlabel "x"
set ylabel "y"
splot (1 + x + y + x**2 + y**2 + x * y) lt 1

unset output