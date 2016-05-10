#!/bin/sh

for HPP in `bash ../../utils/find_hpp.sh ../../Code/Cpp/DataExample.md`; do
  bash ../../utils/make_hpp.sh ${HPP}
  bash ../../utils/make_cpp.sh ${HPP}
done


cd tests

bash ../../../utils/make_test.sh  ../../../Code/Cpp/tests/DataExample.md 

cd ..
