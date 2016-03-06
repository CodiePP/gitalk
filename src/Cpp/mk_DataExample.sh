#!/bin/sh

for HPP in `../../utils/find_hpp.sh ../../Code/Cpp/DataExample.md`; do
  ../../utils/make_hpp.sh ${HPP}
  ../../utils/make_cpp.sh ${HPP}
done


cd tests

../../../utils/make_test.sh  ../../../Code/Cpp/tests/DataExample.md 

cd ..
