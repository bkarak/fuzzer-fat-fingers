#!/bin/sh
#
# Language-specific functionality for compiling and running
# the specified source file
#

compile_js()
{
	# Compile-only.  There is no documentation on the CLI args;
	# see http://git.dyne.org/freej/plain/lib/javascript/js.cpp
	smjs -C $1
}

run_js()
{
	smjs $1
}
