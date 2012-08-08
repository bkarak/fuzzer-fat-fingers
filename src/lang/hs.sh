#!/bin/sh
#
# Language-specific functionality for compiling and running
# the specified source file
#

compile_hs()
{
	EXE=`basename $1 .hs`
	rm -f $EXE
	ghc -o $EXE $1
}

run_hs()
{
	./`basename $1 .hs`
}
