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

	dir=../run/$task/$lang/$fuzzid
	rm -rf $dir
	mkdir -p $dir
	cp $program $dir/
	(
	cd $dir
	base=$(basename $program)
	echo "Testing $task for $lang version $fuzzid" 1>&2
	if ! compile_$lang $base
	then
		log COMPILE $fuzzid FAIL
		return
	fi
	log COMPILE $fuzzid OK
	if ! run_$lang $base >$task.$lang.$fuzzid.output
	then
		log RUN $fuzzid FAIL
		return
	fi
	log RUN $fuzzid OK
	if diff ../$task.$lang.reference $task.$lang.$fuzzid.output
	then
		log OUTPUT $fuzzid OK
	else
		log OUTPUT $fuzzid FAIL
	fi
	)
}

# For each task
for task in $TASKS
do
	echo Testing $task 1>&2
	for lang in $LANGS
	do
		echo Priming $task for $lang 1>&2
		dir=../run/$task/$lang/prime
		rm -rf $dir
		mkdir -p $dir
		cp ../tasks/$task/$task.$lang $dir/
		(
		cd $dir
		if ! compile_$lang $task.$lang
		then
			log COMPILE prime FAIL
			continue
		fi
		log COMPILE prime OK
		if ! run_$lang $task.$lang >../$task.$lang.reference
		then
			log RUN prime FAIL
			continue
		fi
		log RUN prime OK
		)

		echo Testing $task for $lang 1>&2
		test_version original ../tasks/$task/$task.$lang

		echo Testing $task for $lang with fuzz 1 1>&2
		mkdir -p ../run/fuzz/$task/$lang/fuzz1
		perl fuzzer.pl <../tasks/$task/$task.$lang >../run/fuzz/$task/$lang/fuzz1/$task.$lang
		test_version fuzz1 ../run/fuzz/$task/$lang/fuzz1/$task.$lang
	done
done
