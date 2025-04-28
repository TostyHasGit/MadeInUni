#ifndef COMMONVECTOR_H_
#define COMMONVECTOR_H_
#include "pbma.h"

template<typename T, size_t len>
class CommonVector {
public:
	CommonVector();
	~CommonVector();
	size_t size() const;
	T& operator[](size_t idx);
	const T& operator[](size_t idx) const;
	void out(void) const;

private:
	T *elements;
};
#include "CommonVector.cpp"
#endif
