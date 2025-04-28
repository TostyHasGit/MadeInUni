#include "IntVector.h"
#include <iostream>

IntVector::IntVector(size_t len) {
	_len = len;
	_arr = new int[_len]{0};
}

IntVector::~IntVector() {
	std::cout << "destructor IntVector" << std::endl;
	delete[] _arr;
}

IntVector& IntVector::operator=(const IntVector& a){
	delete[] IntVector::_arr;
	_len = a._len;
	_arr = new int[a._len];
	for(size_t i{0}; i < a._len; i++){
		_arr[i] = a._arr[i];
	}

	return  *this;
}

IntVector::IntVector(const IntVector& other){
	_arr = new int[other._len];
	_len = other._len;
	for(size_t i{0}; i < other._len; i++){
		at(i) = other.at(i);
	}
}

size_t IntVector::size() {
	return _len;
}

int& IntVector::at(size_t idx) const{
	if (_len <= idx) {
		throw std::runtime_error("index out of range");
	} else {
		return _arr[idx];
	}
}

void IntVector::out() {
	std::cout << "[ ";
	for (size_t i{0}; i < _len; i++) {
		std::cout << _arr[i] << " ";
	}
	std::cout << "] - " << _len << std::endl;
}

