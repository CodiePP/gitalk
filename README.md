# gitalk

literate programming on Github

write your code in [markdown](https://guides.github.com/features/mastering-markdown/)
parse it with the scripts in [utils[(./utils/)
compile and run.

## example

1. go to src/Cpp

2. run ./mk_DataExample.sh

3. cd tests

>$tests: g++ -g -o utData utData.cpp ../Data.cpp -I.. -std=c++11

4. run

>$tests: ./utData

## features

* combines source fragments from multiple files
* preserves line number information in the code (debugging)
* paste fragments from files with <fpaste ...>

## dependencies

this project depends on 

* [pandoc](http://pandoc.org/)

* html2text

