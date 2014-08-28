all: ipdps.pdf

ipdps.pdf: ipdps.tex beamerthemetotal.sty Makefile
	pdflatex $^
	pdflatex $^
	make clean
	cp $@ ~/pau901

.PHONY: clean clean-all
clean:
	rm -rf *.aux *.log *.nav *.out *.snm *.toc

clean-all: clean
	rm -rf ipdps.pdf
