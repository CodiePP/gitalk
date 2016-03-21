
# Data contructor

declared in [Data](Data.hpp.md)

plain constructor to create an instance of this class.

in the background it is calculating the data following this formula:
![formula](https://raw.githubusercontent.com/CodiePP/gitalk/master/doc/formula01.mathml)

~~~ {.cpp}
Data::Data()
	: _the_data(nullptr)
{
	std::clog << "Data::Data()" << std::endl;
}
~~~

copy constructor to make a new instance initialized with the data of another.
~~~ {.cpp}
Data::Data(Data const & d2)
{
	_the_data = d2._the_data;
}
~~~
