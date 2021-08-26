all: probability1-woven.pdf

clean:
	latexmk -C probability1-woven.tex
	rm probability1-woven.tex

probability1-woven.pdf: probability1-woven.tex probability.bib
	latexmk -pdf probability1-woven.tex

probability1-woven.tex: probability1.Rnw probability1.bib
	Rscript -e "knitr::knit('probability1.Rnw', output = 'probability1-woven.tex')"


