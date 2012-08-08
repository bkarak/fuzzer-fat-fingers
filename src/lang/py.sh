#!/bin/sh
#
# Language-specific functionality for compiling and running
# the specified source file
#

compile_py()
{
	python -c "import py_compile; py_compile.compile(r'$1')"
}

run_py()
{
	python $1
}
