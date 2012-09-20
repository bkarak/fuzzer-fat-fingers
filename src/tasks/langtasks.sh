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
# Print list of tasks ordered by the # of our languages they support
# This script is provided mostly for documentation
# AVOID RUNNING THIS SCRIPT, as it downloads all rosettacode.org
#

mkdir -p ../rosetta

# Create a list of all tasks
curl 'http://rosettacode.org/wiki/Category:Programming_Tasks' |
sed -n 's|^.*<li><a href="/wiki/\([^"]*\).*|\1|p' |

# Download the MediaWiki markup code for each task
while read task
do
        taskfile=`echo $task | sed 's|/|__|g'`
        curl "http://rosettacode.org/mw/index.php?title=$task&action=edit" >../rosetta/$taskfile
        sleep 2
done

# Create list of tasks ordered by the # of our languages they support
cd ../rosetta
for task in *
do
	# Print task:language
	sed -n "s#=={{header|\([^}]*\).*#$task:\1#p"  $task
done |
sort -t: -k2 |
join -1 2 -2 1 -t: - ../lang/ourlangs  |
awk -F: '{print $2}' |
sort |
uniq -c |
sort -rn
