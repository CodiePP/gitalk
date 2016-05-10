#!/bin/sh

for HPP in `sh ../../utils/find_hpp.sh ../../Code/Cpp/DataExample.md`; do
  sh ../../utils/make_hpp.sh ${HPP}
  sh ../../utils/make_cpp.sh ${HPP}
done


cd tests

sh ../../../utils/make_test.sh  ../../../Code/Cpp/tests/DataExample.md 

cd ..
