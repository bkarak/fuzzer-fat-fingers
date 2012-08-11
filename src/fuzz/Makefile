# Copyright [2012] [Diomidis Spinellis <dds@aueb.gr>, Vassilios Karakoidas <bkarak@aueb.gr>]
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#

summary: run.out
	@echo "Results per task"
	@awk '$$3 == "original" && $$5 == "OK"{ status[$$1]++ } END {for (i in status) print i, status[i], "/ 30"}' $<
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
	! perl fuzzer.pl -f IdentifierSubstitution fuzzer.pl | diff -b - fuzzer.pl >/dev/null
	! perl fuzzer.pl -f IntegerPerturbation fuzzer.pl | diff -b - fuzzer.pl >/dev/null
	! perl fuzzer.pl -f RandomCharacterSubstitution fuzzer.pl | diff -b - fuzzer.pl >/dev/null
	! perl fuzzer.pl -f RandomTokenSubstitution fuzzer.pl | diff -b - fuzzer.pl >/dev/null
	! perl fuzzer.pl -f SimilarSubstitution fuzzer.pl | diff -b - fuzzer.pl >/dev/null
