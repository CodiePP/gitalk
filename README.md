# gitalk

literate programming on Github

* write your code in [markdown](https://guides.github.com/features/mastering-markdown/)
* parse it with the scripts in [utils](./utils/)
* compile and run.

## example

`1. go to the directory: src/Cpp
```
cd src/Cpp
```
`2. run script to generate source code
```
./mk_DataExample.sh
```
`3. change to tests directory
```
cd tests

g++ -g -o utData utData.cpp ../Data.cpp -I.. -std=c++11
```
`4. run
```
./utData
```

## features

* combines source fragments from multiple files
* preserves line number information in the code (debugging)
* paste fragments from files with &lt;fpaste ...&gt;

## dependencies

this project depends on 

### Pandoc
* [pandoc](https://pandoc.org/)

### html2text
* [html2text](https://github.com/grobian/html2text.git)

which can be built in /ext:
```sh
git submodule update --init
cd ext/html2text.git
PREFIX=$HOME/.local ./configure
make && make install
```
(point $PREFIX to the installation root path)
