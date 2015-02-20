PDFLATEX_OPTIONS=-file-line-error -interaction=nonstopmode --output-directory=output
RUBBER_OPTIONS=-d
SRC=thesis.tex
DEST=thesis.pdf
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
	@echo "Update images"
	@cd img && ./svg2pdf.sh
	@cd ..
	@cd resultat_rostand  && ./plot.sh && ../img/svg2pdf.sh
	@cd ..
	@cd resultat_manumanu && ./plot.sh && ../img/svg2pdf.sh
	@cd ..


view:
	evince $(DEST)

clean:
	cd output
	rm -f *.bbl *.blg *.log *.maf *.mtc* *.nlo *.out *.toc *.aux
