
all:
	pdflatex fuzzer.tex
	bibtex fuzzer
	pdflatex fuzzer.tex
	pdflatex fuzzer.tex

clean:
	-rm -f fuzzer.aux
	-rm -f fuzzer.log
	-rm -f fuzzer.pdf