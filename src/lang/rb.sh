#!/bin/sh
#
# Language-specific functionality for compiling and running
# the specified source file
#

compile_rb()
{
	ruby -c $1 1>&2
}

run_rb()
{
	ruby $1
}
