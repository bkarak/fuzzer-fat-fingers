#!/bin/sh
#
# Language-specific functionality for compiling and running
# the specified source file
#

compile_java()
{
	javac -d ~ $1
}

run_java()
{
	java -cp ~ `echo $1 | cut -f 1 -d .`
}
