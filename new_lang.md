Fuzz Testing: Add Support for a New Programming Languages
==================

Adding support for a new programming language is simple; just follow these steps:

1. Goto the **lang** directory:
   * Add a file named with the following pattern: **language-file-extension.sh** e.g. for the Pascal programming language, the file should be named: **pas.sh**
   * The file is a shell script that contains two functions; one for compilation and one for execution of a task (see _Language Module_). With <code>$1</code> the source is passed as a parameter to the compiler.
   * The next step includes the addition of the language to the **languages.sh** file in the same directory. The process is simple; just append the source code suffix at the end of the language list.
   * Add the Language to the **ourlangs** file in the same directory.
2. Goto to the **tasks** directory:
   *  Add for all tasks the implementation for the new language e.g. for the **AccumFactory** task, for the Pascal programming language, one should add the **AccumFactory.pas** file.
   
### Language Module for Pascal

```
compile_pas()
{
    pascal-compiler $1
}

run_pas()
{
    ./<executable> <params>
}
```
