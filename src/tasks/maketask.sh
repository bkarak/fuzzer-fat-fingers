#!/bin/sh
#
# Create the specified task with the specified name

if [ -z "$1" ]
then
	echo "Usage: $0 task_name" 1>&2
	exit 1
fi

. ../lang/languages.sh

mkdir -p $1
for i in $LANGS
do
	touch $1/$1.$i
done
