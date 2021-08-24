all: probability-woven.pdf

clean:
	latexmk -C probability-woven.tex
	rm probability-woven.tex

probability-woven.pdf: probability-woven.tex probability.bib
	latexmk -pdf probability-woven.tex

probability-woven.tex: probability.Rnw probability.bib
	Rscript -e "knitr::knit('probability.Rnw', output = 'probability-woven.tex')"


