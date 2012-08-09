#!/bin/sh
#
# Language-specific functionality for compiling and running
# the specified source file
#

compile_m()
{
	EXE=`basename $1 .c`-m
	rm -f $EXE
        gobjc -o $EXE $1
}

run_m()
{
	./`basename $1 .c`-m
}
