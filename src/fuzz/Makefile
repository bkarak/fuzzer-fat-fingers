summary: run.out
	awk '$$3 == "original" && $$5 == "OK"{ status[$$1]++ } END {for (i in status) print i, status[i], "/ 33"}' $<

run.out:
	bash run.sh >$@

test:
	perl -c fuzzer.pl
	perl fuzzer.pl -t Makefile | diff Makefile -
	perl fuzzer.pl -t fuzzer.pl | diff fuzzer.pl -
	! perl fuzzer.pl fuzzer.pl | diff - fuzzer.pl >/dev/null
	! perl fuzzer.pl Makefile | diff - Makefile >/dev/null
