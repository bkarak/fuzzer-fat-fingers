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
FUZZFUNCS="`perl fuzzer.pl -l`"
FUZZ=1

while getopts 'f:l:t:v' opt; do
  case $opt in
    f)
      FUZZFUNCS="$OPTARG"
      ;;
    t)
      TASKS="$OPTARG"
      ;;
    l)
      LANGS="$OPTARG"
      ;;
    v)
      FUZZ=0
      ;;
    \?)
      cat <<EOF >&2
"Invalid option: -$OPTARG"
Usage: $0 [-l lang] [-t task] [-v]
-f fuzzfunc	Execute only the specified fuzz function
-l lang		Run only specified language
-t task		Run only specified task
-v		Verify tasks, to not fuzz
EOF
      exit 1
      ;;
  esac
done


# Log phase, id, and result
log()
{
	echo "$task $lang $2 $1 $3"
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

rm -rf ../run

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

		if [ "$FUZZ" -eq 0 ]
		then
			continue
		fi
		for fuzz in $FUZZFUNCS
		do
			echo Fuzzing $task for $lang with $fuzz 1>&2
			mkdir -p ../run/fuzz/$task/$lang/$fuzz
			if perl fuzzer.pl <../tasks/$task/$task.$lang >../run/fuzz/$task/$lang/$fuzz/$task.$lang
			then
				log FUZZ $fuzz  OK
			else
				log FUZZ $fuzz  FAIL
				continue
			fi
			test_version $fuzz ../run/fuzz/$task/$lang/$fuzz/$task.$lang
		done
	done
done
