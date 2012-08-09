fuzzer-plateau-2012
===================

My idea involves determining the resilience of programming languages to typos by fuzzing the source code of the same application written in several popular languages.  We would want to see whether the fuzzed program compiles, runs, crashes, loops, produces wrong results. As basis for the code we can use Rosetta Code [[3]]((http://rosettacode.org/), though we will need to write a test harness for each task.  The fuzzer should be relatively simple, adding, removing, and moving symbols and identifiers around the program.

The work I see involves the following:

* Select languages
* Select tasks
* Write fuzzer
* Write test harnesses
* Run
* Write paper

Now comes the difficult part: The submission deadline is August 10th! Papers should be 4-10 pages using the ACM SIGPLAN template with 10pt font [(Author Information)](http://www.sigplan.org/authorInformation.htm). All accepted papers will be published in the ACM Digital Library.  Are you interested to work on this?  Do you think we can make it?


[[1] http://splashcon.org/2012/program/panels/460-software-tools-research-panel](http://splashcon.org/2012/program/panels/460-software-tools-research-panel)

[[2] https://sites.google.com/site/workshopplateau/call-for-submissions](https://sites.google.com/site/workshopplateau/call-for-submissions)

[[3] http://rosettacode.org/](http://rosettacode.org/)

Selected languages (based on popularity)
----------------------------------------

* Java (OpenJDK 1.6.0_18)
* C (gcc 4.4.5)
* C++ (g++ 4.4.5)
* PHP (PHP 5.3.3-7)
* C# (mono 2.6.7, CLI v2.0)
* VB (bwbasic 2.20 [http://sourceforge.net/projects/bwbasic/](http://sourceforge.net/projects/bwbasic/))
* Python (python 2.6.6)
* Objective-C (GNU Objective-C 4.4.5)
* Perl (perl 5.10.1)
* Javascript (spidermonkey smjs 1.8.0)
* Haskell (ghc 6.12.1)
* Ruby (ruby 1.5.8)
* Not Included
  * Actionscript (?)
  * Shell (bash, csh (?))
  * SQL (?)
  * OC (ocaml 3.11.2)

Proposed Tasks
--------------
We want each task to be available in all the languages, to be non-trivial and easy to test via its standard input and standard output.

Selected:

* [http://rosettacode.org/wiki/Day_of_the_week](http://rosettacode.org/wiki/Day_of_the_week)
* [http://rosettacode.org/wiki/Flatten_a_list](http://rosettacode.org/wiki/Flatten_a_list)
* [http://rosettacode.org/wiki/Accumulator_factory](http://rosettacode.org/wiki/Accumulator_factory)

* [http://rosettacode.org/wiki/Function_composition](http://rosettacode.org/wiki/Function_composition)
* [http://rosettacode.org/wiki/Determine_if_a_string_is_numeric](http://rosettacode.org/wiki/Determine_if_a_string_is_numeric)
* [http://rosettacode.org/wiki/Dot_product](http://rosettacode.org/wiki/Dot_product)

Disqualified:

* [http://rosettacode.org/wiki/Pi](http://rosettacode.org/wiki/Pi) - missing languages
* [http://rosettacode.org/wiki/N-queens_problem](http://rosettacode.org/wiki/N-queens_problem) - missing languages
* [http://rosettacode.org/wiki/Conway%27s_Game_of_Life](http://rosettacode.org/wiki/Conway%27s_Game_of_Life) - complex output

Pool:

* [http://rosettacode.org/wiki/CSV_to_HTML_translation](http://rosettacode.org/wiki/CSV_to_HTML_translation)
* [http://rosettacode.org/wiki/Letter_frequency](http://rosettacode.org/wiki/Letter_frequency)
* [http://rosettacode.org/wiki/Numerical_integration](http://rosettacode.org/wiki/Numerical_integration)

