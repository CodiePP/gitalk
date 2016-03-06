
# unit test

## compilation

~~~
cd src/Cpp/tests
g++ -o utData utData.cpp ../Data.cpp -I.. -std=c++11
~~~

## header

~~~ {.cpp}
#include <iostream>

#include "Data.hpp"

~~~

## main procedure

~~~ {.cpp}

int main (int argc, char **argv)
{
	mine::Data d1;
	{
		mine::Data d2;
	}

	return 0;
}
~~~
