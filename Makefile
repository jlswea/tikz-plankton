PACKAGES = plankton-base plankton-electrical plankton-plumbing \
           plankton-hvac plankton-furniture plankton-site
STY = $(addsuffix .sty,$(PACKAGES))
EXAMPLES = $(wildcard examples/*.tex)
EXAMPLE_PDFS = $(EXAMPLES:.tex=.pdf)

.PHONY: all sty doc examples ctan clean

all: sty doc examples

sty: $(STY)
$(STY): plankton.dtx plankton.ins
	latex plankton.ins

doc: plankton.pdf
plankton.pdf: plankton.dtx $(STY)
	pdflatex plankton.dtx
	makeindex -s gind.ist plankton.idx
	makeindex -s gglo.ist -o plankton.gls plankton.glo
	pdflatex plankton.dtx
	pdflatex plankton.dtx

examples: $(EXAMPLE_PDFS)
examples/%.pdf: examples/%.tex $(STY)
	cd examples && TEXINPUTS=".:..:" pdflatex -interaction=nonstopmode \
	  -halt-on-error $(<F)

ctan: sty doc
	mkdir -p plankton/examples
	cp plankton.dtx plankton.ins plankton.pdf README.md LICENSE plankton/
	cp examples/*.tex plankton/examples/
	zip -r plankton.zip plankton/
	rm -rf plankton/
	@echo "Created plankton.zip for CTAN upload"

clean:
	rm -f $(STY) *.aux *.log *.idx *.ind *.ilg *.gls *.glo *.glg \
	  *.toc *.out *.hd *.pdf
	rm -f examples/*.aux examples/*.log examples/*.pdf
