#!/bin/sh
#
# Language-specific functionality for compiling and running
# the specified source file
#

compile_cs()
{
	mono-csc $1 1>&2
}

run_cs()
{
	mono `basename $1 .cs`.exe
}
