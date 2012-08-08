#!/bin/sh
#
# Language-specific functionality for compiling and running
# the specified source file
#

compile_pl()
{
	perl -c $1
}

run_pl()
{
	perl $1
}
