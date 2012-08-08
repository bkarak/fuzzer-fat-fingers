#!/usr/bin/bash
#
# Run the fuzzer on all tasks and report the results
#

. ../lang/languages.sh

# Source language-specific functionality
for lang in $LANGS
do
	touch ../lang/$lang.sh
	. ../lang/$lang.sh
done

TASKS=$(cd ../tasks ; find . -maxdepth 1 -type d | sed '/^\.$/d;s/^\.\///')
echo $TASKS
# For each task
for task in $TASKS
do
	echo Testing $task
	for lang in $LANGS
	do
		echo Testing $task for $lang
	done
done
