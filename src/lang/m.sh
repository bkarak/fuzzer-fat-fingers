#!/bin/sh
#
# Language-specific functionality for compiling and running
# the specified source file
#

compile_m()
{
	EXE=`basename $1 .m`-m
	rm -f $EXE
        gcc `gnustep-config --base-libs --objc-flags` -O -c $1
	#gcc `gnustep-config --base-libs` -o $EXE $1
}

run_m()
{
	./`basename $1 .c`-m
}
