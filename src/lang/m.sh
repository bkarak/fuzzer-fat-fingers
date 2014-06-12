#!/bin/sh
#
# Copyright [2012] [Diomidis Spinellis <dds@aueb.gr>, Vassilios Karakoidas <bkarak@aueb.gr>]
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
#

compile_m()
{
	EXE=`basename $1 .m`-m
	rm -f $EXE
    gcc `gnustep-config --base-libs --objc-flags` -O -c $1
	#gcc `gnustep-config --base-libs` -o $EXE $1
}

run_m()
{
	./`basename $1 .c`-m
}
