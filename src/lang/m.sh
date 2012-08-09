#!/bin/sh
#
# Language-specific functionality for compiling and running
# the specified source file
#

compile_m()
{
	EXE=`basename $1 .c`-m
	rm -f $EXE
        gcc -g -fgnu-runtime -O -c $1
	gcc -o $EXE -Wno-import `basename $1 .m`.o  -lobjc
}

run_m()
{
	./`basename $1 .c`-m
}
