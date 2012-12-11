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
# Create the specified task with the specified name

if [ -z "$1" ]
then
	echo "Usage: $0 task_name" 1>&2
	exit 1
fi

. ../lang/languages.sh

mkdir -p $1
for i in $LANGS
do
	touch $1/$1.$i
done
