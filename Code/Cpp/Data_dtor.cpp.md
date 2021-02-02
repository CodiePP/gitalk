
# Data destructor

declared in [Data](Data.hpp.md)

The destructor is not doing much, so it should not have a big impact on program execution time.
And its space complexity is nearing zero.

```c++

Data::~Data()
{
	std::clog << "Data::~Data()" << std::endl;
}

```
