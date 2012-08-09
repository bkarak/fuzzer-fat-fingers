#!/bin/sh
#
# Language-specific functionality for compiling and running
# the specified source file
#

compile_py()
{
	python /usr/lib/python2.6/py_compile.py $1
}

run_py()
{
	python $1
}
