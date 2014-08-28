PDFLATEX_OPTIONS=-file-line-error -interaction=nonstopmode --output-directory=output
RUBBER_OPTIONS=-d --cache  
SRC=thesis.tex
DEST=thesis.pdf

all: imgs
	rubber $(RUBBER_OPTIONS) $(SRC)
	mv $(DEST) $(DEST).tmp
	rubber --clean $(SRC)
	mv $(DEST).tmp $(DEST)
#	pdflatex $(PDFLATEX_OPTIONS) $(SRC)
#	bibtex output/thesis || echo "No bib"
#	pdflatex $(PDFLATEX_OPTIONS) $(SRC)
#	pdflatex $(PDFLATEX_OPTIONS) $(SRC)

.PHONY: imgs view

imgs:
	cd img && ./svg2pdf.sh

view:
	evince $(DEST)

clean:
	cd output
	rm -f *.bbl *.blg *.log *.maf *.mtc* *.nlo *.out *.toc *.aux
