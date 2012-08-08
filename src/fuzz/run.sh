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
LANGS="java pl py cs php c cpp rb hs"

# Log phase, id, and result
log()
{
	echo "$task $lang $1 $2 $3"
}

# Test the specified fuzz and program
test_version()
{
	fuzzid=$1
	program=$2
	echo "Testing $task for $lang version $fuzzid" 1>&2
	if ! compile_$lang $program
	then
		log COMPILE $fuzzid FAIL
		return
	fi
	log COMPILE $fuzzid OK
	if ! run_$lang $task.$lang >$task.$lang.$fuzzid.output
	then
		log RUN $fuzzid FAIL
		return
	fi
	log RUN $fuzzid OK
	if diff $task.$lang.reference $task.$lang.$fuzzid.output
	then
		log OUTPUT $fuzzid OK
	else
		log OUTPUT $fuzzid FAIL
	fi
}

# For each task
for task in $TASKS
do
	echo Testing $task 1>&2
	(
	cd ../tasks/$task
	for lang in $LANGS
	do
		echo Priming $task for $lang 1>&2
		if ! compile_$lang $task.$lang
		then
			log COMPILE prime FAIL
			continue
		fi
		log COMPILE prime OK
		if ! run_$lang $task.$lang >$task.$lang.reference
		then
			log RUN prime FAIL
			continue
		fi
		log RUN prime OK
		echo Testing $task for $lang 1>&2
		test_version original $task.$lang
	done
	)
done
