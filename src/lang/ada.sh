#!/bin/sh
# Copyright [2012-14] [David A. Wheeler <dwheeler@dwheeler.com>, Diomidis Spinellis <dds@aueb.gr>, Vassilios Karakoidas <bkarak@aueb.gr>]
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#
# Language-specific functionality for compiling and running
# the specified source file

# The original code is in ".ada" files, which is unusual.
# In normal use GNAT has specific file content and naming conventions that
# the fuzzing driver doesn't support.  E.G., Ada specifications must be
# in ".ads" files, Ada bodies (implementations of the specifications) must
# be in ".adb" files, and the filenames must match the package name but
# be in lower case.  Thus, we'll put the source code in one ".ada" file
# and use "gnatchop" to divide it into multiple files during compilation.
# This ".ada" file may have name changes (as compared to Rosetta Stone)
# so that the (main) library level subprogram body has the executable name
# (e.g., in task "Hello" the subprogram body name is changed
# from "Main" to "Hello").  That way, we know from the name where to start.
# By doing things this way we don't have to change the main fuzzer driver.

# We enable -gnato, which enables integer overflow checking as required
# by the Ada standard.  In May 2014 the GNAT developers changed this so
# that this option is the default; this way, it will be enabled on
# older GNAT compilers as well.
compile_ada()
{
	if [ -f "$1" ] ; then
	  LOWERCASE=`printf '%s' "$1" | tr A-Z a-z`
	  TOPLEVEL=`basename "$LOWERCASE" .ada`
	  EXE="$TOPLEVEL"
	  rm -f "$EXE"
	  gnatchop "$1"
	  gnatmake -gnato -o "$EXE" "$TOPLEVEL"
	else
	  false
	fi
}

run_ada()
{
	LOWERCASE=`printf '%s' "$1" | tr A-Z a-z`
	EXE=`basename "$LOWERCASE" .ada`
	./`basename $EXE`
}

