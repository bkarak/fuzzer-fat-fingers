all:
	latex fuzzer.tex
	latex fuzzer.tex
	dvips -P pdf -t letter -o fuzzer.ps fuzzer.dvi
	pdflatex fuzzer
	pdflatex fuzzer

clean:
	-rm -f fuzzer.aux
	-rm -f fuzzer.log
	-rm -f fuzzer.pdf
	-rm -f fuzzer.bbl
	-rm -f fuzzer.blg
	-rm -f fuzzer.ps
	-rm -f fuzzer.dvi
