summary: run.out
	@echo "Results per task"
	@awk '$$3 == "original" && $$5 == "OK"{ status[$$1]++ } END {for (i in status) print i, status[i], "/ 33"}' $<
	@echo "Results per language"
	@awk 'BEGIN {ntasks = '`find ../tasks -maxdepth 1 -type d | wc -l`'} $$3 == "original" && $$5 == "OK"{ status[$$2]++ } END {for (i in status) print i, status[i], "/ ", ntasks * 3}' $<

run.out:
	bash run.sh >$@

clean:
	rm -f run.out

test:
	perl -c fuzzer.pl
	perl fuzzer.pl -t Makefile | diff -b Makefile -
	perl fuzzer.pl -t fuzzer.pl | diff -b fuzzer.pl -
	! perl fuzzer.pl fuzzer.pl | diff -b - fuzzer.pl >/dev/null
	! perl fuzzer.pl Makefile | diff -b - Makefile >/dev/null
