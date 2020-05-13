export TEXINPUTS=../tex//:

all: thesis.pdf abstract.pdf 

# LaTeX must be run multiple times to get references right
thesis.pdf: $(wildcard *.tex) bibliography.bib thesis.xmpdata
#	cp thesis.pdf ../thesis.pdf

%.pdf: %.tex
	#pdflatex $<
	#bibtex $* || ( echo "Bibtex failed" && exit 1 )
	## change the exit 1 to exit 0 in the line above if you want to ignore it
	#lim=4; \
	#  while [ $$lim -ge 0 ] \
	#      && grep 'Rerun to get\|Citation.*undefined' $*.log >/dev/null 2>/dev/null; do \
	#    pdflatex $< ; \
	#    lim=$$(($$lim - 1)) ; \
	#  done

	pdflatex $<
	bibtex thesis
	pdflatex $<
	pdflatex $<

abstract.pdf: abstract.tex abstract.xmpdata
	pdflatex $<

clean:
	rm -f *.log *.dvi *.aux *.toc *.lof *.lot *.out *.bbl *.blg *.xmpi

clean_all: clean
	rm -f thesis.pdf abstract.pdf
