PDFLATEX_OPTIONS=-file-line-error -interaction=nonstopmode --output-directory=output
RUBBER_OPTIONS=-d --cache  
SRC=slide.tex
DEST=slide.pdf
RUBBER_VERSION := $(shell rubber --version 2>/dev/null)

all: imgs
ifdef RUBBER_VERSION
	rubber $(RUBBER_OPTIONS) $(SRC)
	mv $(DEST) $(DEST).tmp
	rubber --clean $(SRC)
	mv $(DEST).tmp $(DEST)
else
	pdflatex $(PDFLATEX_OPTIONS) $(SRC)
	bibtex output/thesis || echo "No bib"
	pdflatex $(PDFLATEX_OPTIONS) $(SRC)
	pdflatex $(PDFLATEX_OPTIONS) $(SRC)
	mv output/$(DEST) $(DEST)
endif

.PHONY: imgs view

imgs:
	cd img && bash ./svg2pdf.sh

view:
	evince $(DEST)

clean:
	cd output
	rm -f *.bbl *.blg *.log *.maf *.mtc* *.nlo *.out *.toc *.aux
