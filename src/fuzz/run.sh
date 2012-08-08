#!/usr/bin/bash
#
# Run the fuzzer on all tasks and report the results
#

. ../lang/languages.sh

# Source language-specific functionality
for lang in $LANGS
do
	. ../lang/$lang.sh
done

TASKS=$(cd ../tasks ; find . -maxdepth 1 -type d | sed '/^\.$/d;s/^\.\///')

TASKS=Hello
LANGS=java

# For each task
for task in $TASKS
do
	echo Testing $task 1>&2
	(
	cd ../tasks/$task
	for lang in $LANGS
	do
		echo Testing $task for $lang 1>&2
		if ! compile_$lang $task.$lang
		then
			echo "$task $lang COMPILE FAIL"
			continue
		fi
		echo "$task $lang COMPILE OK"
		if ! run_$lang $task.$lang >$task.$lang.output
		then
			echo "$task $lang RUN FAIL"
			continue
		fi
		echo "$task $lang RUN OK"
		if diff $task.reference $task.$lang.output
		then
			echo "$task $lang OUTPUT OK"
		else
			echo "$task $lang OUTPUT FAIL"
		fi
	done
	)
done
