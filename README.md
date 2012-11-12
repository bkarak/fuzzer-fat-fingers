fuzzer-fat-fingers
==================

License
-------

 Copyright [2012] [Diomidis Spinellis <dds@aueb.gr>, Vassilios Karakoidas <bkarak@aueb.gr>]

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.

Repository Structure
--------------------

* **pub/** : PLATAEU 2012, Publication (LaTeX format)
* **src/**
  * _fuzz/_ : Fuzzer implementation (Perl) and main execution script (run.sh)
  * _lang/_ : Scripts for compilation and execution of programs in the selected languages
  * _run/_ : Temporary directory, used when the benchmark is running.
  * _stats/_ : Data analysis scripts (Python)
  * _tasks/_ : Rosseta Code task implementations

Execution
---------

To execute the fuzzer scripts on some or all tasks, you need to execute the **run.sh** script, located in 
_src/fuzz_ directory of the repository.

    Usage: $0 [-l lang] [-t task] [-v]
    -f fuzzfunc Execute only the specified fuzz function
    -l lang   Run only specified language
    -t task   Run only specified task
    -v    Verify tasks, to not fuzz

If no parameter is specified, the shell script will execute all the tasks available in the _src/tasks/_ directory for all the languages that are specified in the _src/lang_ directory.

Selected languages (based on popularity/IEEE Article)
-----------------------------------------------------

* Java (OpenJDK 1.6.0_18)
* C (gcc 4.4.5)
* C++ (g++ 4.4.5)
* PHP (PHP 5.3.3-7)
* C# (mono 2.6.7, CLI v2.0)
* Python (python 2.6.6)
* Perl (perl 5.10.1)
* Javascript (spidermonkey smjs 1.8.0)
* Haskell (ghc 6.12.1)
* Ruby (ruby 1.8.7)
* Not Included
  * Actionscript (?)
  * Shell (bash, csh (?))
  * SQL (?)
  * OC (ocaml 3.11.2)
  * VB (bwbasic 2.20 [http://sourceforge.net/projects/bwbasic/](http://sourceforge.net/projects/bwbasic/))
  * Objective-C (GNU Objective-C 4.4.5)

Selected Tasks
--------------
We want each task to be available in all the languages, to be non-trivial and easy to test via its standard input and standard output.

* [http://rosettacode.org/wiki/Day_of_the_week](http://rosettacode.org/wiki/Day_of_the_week)
* [http://rosettacode.org/wiki/Flatten_a_list](http://rosettacode.org/wiki/Flatten_a_list)
* [http://rosettacode.org/wiki/Accumulator_factory](http://rosettacode.org/wiki/Accumulator_factory)
* [http://rosettacode.org/wiki/Function_composition](http://rosettacode.org/wiki/Function_composition)
* [http://rosettacode.org/wiki/Horner%27s_rule_for_polynomial_evaluation](http://rosettacode.org/wiki/Horner%27s_rule_for_polynomial_evaluation)
* [http://rosettacode.org/wiki/Ethiopian_multiplication](http://rosettacode.org/wiki/Ethiopian_multiplication)
* [http://rosettacode.org/wiki/Mutual_recursion](http://rosettacode.org/wiki/Mutual_recursion)
* [http://rosettacode.org/wiki/Man_or_boy_test](http://rosettacode.org/wiki/Man_or_boy_test)
* [http://rosettacode.org/wiki/Power_set](http://rosettacode.org/wiki/Power_set)
* [http://rosettacode.org/wiki/Tokenize_a_string](http://rosettacode.org/wiki/Tokenize_a_string)
* [http://rosettacode.org/wiki/Zig-zag_matrix](http://rosettacode.org/wiki/Zig-zag_matrix)
* [http://rosettacode.org/wiki/99_Bottles_of_Beer](http://rosettacode.org/wiki/99_Bottles_of_Beer)
* [http://rosettacode.org/wiki/Count_occurrences_of_a_substring](http://rosettacode.org/wiki/Count_occurrences_of_a_substring)
* [http://rosettacode.org/wiki/100_doors] (http://rosettacode.org/wiki/100_doors)
* [http://rosettacode.org/wiki/Anagrams] (http://rosettacode.org/wiki/Anagrams)
* [http://rosettacode.org/wiki/Arithmetic/Integer] (http://rosettacode.org/wiki/Arithmetic/Integer)
* [http://rosettacode.org/wiki/Averages/Pythagorean_means] (http://rosettacode.org/wiki/Averages/Pythagorean_means)
* [http://rosettacode.org/wiki/Averages/Root_mean_square] (http://rosettacode.org/wiki/Averages/Root_mean_square)
* [http://rosettacode.org/wiki/Averages/Simple_moving_average] (http://rosettacode.org/wiki/Averages/Simple_moving_average)
* [http://rosettacode.org/wiki/Balanced_brackets] (http://rosettacode.org/wiki/Balanced_brackets)
*