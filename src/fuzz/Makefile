test:
	perl -c fuzzer.pl
	perl fuzzer.pl -t Makefile | diff Makefile -
	perl fuzzer.pl -t fuzzer.pl | diff fuzzer.pl -
	! perl fuzzer.pl fuzzer.pl | diff - fuzzer.pl >/dev/null
	! perl fuzzer.pl Makefile | diff - Makefile >/dev/null
