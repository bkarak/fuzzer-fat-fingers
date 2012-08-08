#!/bin/sh
#
# Language-specific functionality for compiling and running
# the specified source file
#

compile_cpp()
{
	EXE=`basename $1 .cpp`
	rm -f $EXE
	g++ -o $EXE $1
}

run_cpp()
{
	./`basename $1 .cpp`
}
