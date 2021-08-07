all: probability.pdf

probability.pdf: probability.tex
	latexmk -pdf probability.tex

probability.tex: probability.Rnw
	Rscript -e "knitr::knit('probability.Rnw', output='probability.tex')"


