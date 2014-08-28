SOURCE=solver_gpu

all:
	pdflatex ${SOURCE}.tex
	bibtex ${SOURCE}
	pdflatex ${SOURCE}.tex
	pdflatex ${SOURCE}.tex

clean:
	rm -rf *~ *.aux *.bbl *.log *.blg *.dvi *.ps *.pdf
