#!/bin/sh
#
# Language-specific functionality for compiling and running
# the specified source file
#

compile_c()
{
	EXE=`basename $1 .c`
	rm -f $EXE
	gcc -lm -o $EXE $1
}

run_c()
{
	./`basename $1 .c`
}
