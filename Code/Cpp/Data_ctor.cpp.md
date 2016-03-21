
# Data contructor

declared in [Data](Data.hpp.md)

plain constructor to create an instance of this class.

in the background it is calculating the data following this formula:
![ncbi formula renderer](http://www.ncbi.nlm.nih.gov/pmc/utils/math/?file=&in-format=latex&latex-style=text&q=2^x+%2B+1&width=621)

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
