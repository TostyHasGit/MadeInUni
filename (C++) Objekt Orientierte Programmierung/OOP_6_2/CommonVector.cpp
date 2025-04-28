#include "CommonVector.h"
#ifndef COMMONVECTOR_CPP
#define COMMONVECTOR_CPP

template<typename T, size_t len>
size_t CommonVector<T, len>::size() const {
	return len;
}
template<typename T, size_t len>
T& CommonVector<T, len>::operator[](size_t idx) {
	if (idx >= len) {
		throw std::runtime_error("CommonVector: idx out of bounds");
	}
	return elements[idx];
}
template<typename T, size_t len>
const T& CommonVector<T, len>::operator[](size_t idx) const {
	if (idx >= len) {
		throw std::runtime_error("const CommonVector: idx out of bounds");
	}
	return elements[idx];
}
template<typename T, size_t len>
CommonVector<T, len>::CommonVector() {
	elements = new T[len] { }; // {} Initialisierung
}
template<typename T, size_t len>
CommonVector<T, len>::~CommonVector() {
	delete[] elements;
}

template<typename T, std::size_t len>
void CommonVector<T, len>::out(void) const {
	std::cout << "[ ";
	for (std::size_t i = 0; i < len; i += 1) {
		if (i > 0 && i % 10 == 0) {
			std::cout << std::endl << " ";
		}
		std::cout << elements[i] << " ";
	}
	std::cout << "]";
}
#endif
