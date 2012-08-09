#!/bin/sh
#
# Language-specific functionality for compiling and running
# the specified source file
#

compile_cs()
{
	mcs $1 1>&2 || mono-csc $1 1>&2
}

run_cs()
{
	mono `basename $1 .cs`.exe
}
