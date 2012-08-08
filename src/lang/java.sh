#!/bin/sh
#
# Language-specific functionality for compiling and running
# the specified source file
#

compile_java()
{
	javac $1
}

run_java()
{
	java `basename $1 .java`
}
