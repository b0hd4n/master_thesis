export TEXINPUTS=../tex//:

all: thesis.pdf abstract_en.pdf abstract_cz.pdf

# LaTeX must be run multiple times to get references right
thesis.pdf: $(wildcard *.tex) $(wildcard src/*.tex) bibliography.bib thesis.xmpdata
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
	makeglossaries thesis
	pdflatex $<
	pdflatex $<

abstract_%.pdf: abstract_%.tex abstract_%.xmpdata
	pdflatex $<

clean:
	cd src && rm -f *.log *.dvi *.aux *.toc *.lof *.lot *.out *.bbl *.blg *.xmpi
	cd src && rm -f *.acn *.acr *.alg *.glg *.glo *.gls *.ist
	rm -f *.log *.dvi *.aux *.toc *.lof *.lot *.out *.bbl *.blg *.xmpi
	rm -f *.acn *.acr *.alg *.glg *.glo *.gls *.ist

clean_all: clean
	rm -f thesis.pdf abstract.pdf

.PHONY: ci
ci:
	# make sure git will remember my password
	git config credential.helper store
	# git pull push dance with possibly uncommited local modifications
	if git pull; then echo No changes to hide; else git stash; git pull; git stash apply; fi; git commit -am "make ci by $(USER)"; git push
