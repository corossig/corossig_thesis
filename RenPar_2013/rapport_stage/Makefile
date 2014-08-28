LATEX=rubber

RAPPORTS=rapport.pdf

all: $(RAPPORTS)

%.pdf: %.tex
	$(LATEX) -d $^
	make tmpclear

tmpclear:
	rm -rf *.o *.aux *.log *.toc *~ *.bbl *.blg *.out

clean:
	make tmpclear
	rm -rf $(RAPPORTS)
