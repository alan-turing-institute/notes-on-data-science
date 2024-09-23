reset
# set terminal qt size 300,200
# set terminal cairolatex pdf lw 2 fontscale 0.5 size 7cm,5cm
set terminal pdfcairo font "Fira Code,9" fontscale 0.5 rounded size 7cm,5cm

# set lmargin explicitly to line up plotting areas
set lmargin 6

load "moreland.pal"

set xlabel "x"
set grid back
# set size ratio 0.75
set zeroaxis lt -1 lc "dark-grey"
set key opaque
set output "sinxpx2.pdf"


## The original function we are seeking to minimise
set output "sinxpx2.pdf"
set xrange [-2 : 1]
set yrange [-0.5 : 1 ]
set ytics 0.5
plot x**2 + sin(x) ls 1 lw 2 title "x^2+sin(x)"
unset output

## The derivative of the function, and a linear approximation
set output "cosxp2x.pdf"
set yrange [-2:4]
set xrange [-2:1]
set ytics 1
set key invert

$guesses << EOD
0 1 "x_0"
-0.5 0 "x_1"
EOD

plot 1 + 2*x ls 6 title "Linear approx. around x = 0",\
     2*x + cos(x) ls 1 lw 2 title "2x+cos(x)",\
     $guesses with labels point ls 6 pt 7 pointsize 0.3 offset -1.6,0.8 title ""

unset output

## Approximating directly by a quadratic
set output "sinxpx2-approx.pdf"
set xrange [-2 : 1]
set yrange [-0.5 : 1.5 ]
set ytics 0.5
plot x + x**2 ls 6 title "Quadratic approx. around x = 0",\
     x**2 + sin(x) ls 1 lw 2 title "x^2+sin(x)"
unset output

## An enlarged view of the zero
set output "zoom.pdf"
set xrange [-0.6:-0.4]
set yrange [-0.2:0.2]
set ytics 0.1
set xtics 0.1
set key invert

plot -1 + cos(-0.5) + (2 -sin(-0.5)) * (x+0.5) title "Linear approx. around x_1 = -0.5",\
     1 + 2*x ls 6 title "Linear approx. around x_0 = 0",\
     2*x + cos(x) ls 1 lw 2 title "2x+cos(x)",\
     $guesses with labels point ls 6 pt 7 pointsize 0.3 offset -1.6,0.8 title ""

unset output
