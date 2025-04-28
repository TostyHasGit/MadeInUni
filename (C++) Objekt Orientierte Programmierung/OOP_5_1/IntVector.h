#ifndef INTVECTOR_H_
#define INTVECTOR_H_
#include <iostream>

class IntVector {
public:
	IntVector() : IntVector(10) {
	}
	IntVector(size_t len);
	~IntVector();
	IntVector& operator=(const IntVector& a);
	IntVector(const IntVector& other);
	size_t size();
	int& at(size_t idx) const;
	void out();

private:
	int* _arr;
	size_t _len;
};

#endif
