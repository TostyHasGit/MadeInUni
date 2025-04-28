#include "Sequence.h"
#ifndef SEQUENCE_CPP
#define SEQUENCE_CPP

template<typename T>
Sequence<T>::Sequence(size_t cap) :
		_cap { cap } {
	_array = new T[_cap]; // T muss Standardkonstruktor haben
	_size = 0;
}
template<typename T>
Sequence<T>::~Sequence() {
	delete[] _array;
}

template<typename T>
Sequence<T>::Sequence(const Sequence &other) :
	_cap { other._cap }, _size { other._size } {
	_array = new T[_cap];
	for (size_t i = 0; i < _size; i += 1) {
		_array[i] = other._array[i];
	}
}
template<typename T>
Sequence<T>& Sequence<T>::operator=(const Sequence &other) {
	Sequence tmp { other }; // copy and swap
	std::swap(_cap, tmp._cap);
	std::swap(_size, tmp._size);
	std::swap(_array, tmp._array);
	return *this;
}

template<typename T>
size_t Sequence<T>::size() const {
	return _size;
}

template<typename T>
size_t Sequence<T>::capacity() const {
	return _cap;
}
template<typename T>
void Sequence<T>::trim(){
	if(is_empty()){
		return;
	}
	T* temp = new T[_size];
	for(size_t i{0}; i < _size; ++i){
		temp[i] = _array[i];
	}
	delete[] _array;
	_cap = _size;
	_array = temp;
}

template<typename T>
bool Sequence<T>::is_empty() const {
	return _size == 0;
}

template<typename T>
T& Sequence<T>::operator[](size_t pos) {
	if (pos >= _size) {
		std::string msg { "Sequence::operator[]: pos out of bounds" };
		throw std::runtime_error(msg);
	}
	return _array[pos];
}
template<typename T>
const T& Sequence<T>::operator[](size_t pos) const {
	if (pos >= _size) {
		std::string msg { "const Sequence::operator[]: pos out of bounds" };
		throw std::runtime_error(msg);
	}
	return _array[pos];
}
template<typename T>
void Sequence<T>::insert(size_t pos, const T &ele) {
	if (pos > _size) {
		throw std::runtime_error("Sequence::insert: pos out of bounds");
	}
	grow_on_demand(); // wachse, wenn notwendig, mindestens eins frei
	for (size_t idx = _size; idx > pos; idx -= 1) {
		_array[idx] = _array[idx - 1];
	}
	_size += 1;
	_array[pos] = ele;
}
template<typename T>
void Sequence<T>::clear(){
	if(is_empty()){
		return;
	}
	for(size_t i{0}; i < _size; ++i){
		_array[i] = 0;
	}
	_cap = 1;
	_size = 0;
}

template<typename T>
void Sequence<T>::push_back(const T &ele) {
	insert(_size, ele);
}
template<typename T>
void Sequence<T>::remove(size_t pos) {
// Alle Elemente vor Löschposition nach vorne
	if (pos >= _size) {
		throw std::runtime_error("Sequence::remove: pos out of bounds");
	}
	_size -= 1;
	for (size_t idx = pos; idx < _size; idx += 1) {
		_array[idx] = _array[idx + 1];
	}
}
template<typename T>
bool Sequence<T>::remove_ele(const T &ele) {
// Suche erstes Vorkommen und entferne gdw gefunden
	size_t pos = 0;
	while (pos < _size && !(_array[pos] == ele)) { // == auf T notwendig
		pos += 1;
	}
	if (pos < _size) {
		remove(pos);
		return true;
	}
	return false;
}
template<typename T>
bool Sequence<T>::operator==(const Sequence& other)const{
	if(_size != other._size){
		return false;
	}
	for (size_t i = 0; i < _size; ++i) {
		if(_array[i] != other._array[i]){
			return false;
		}
	}
	return true;
}

template<typename T>
void show(const Sequence<T> &seq) {
	std::cout << "[" << seq.size() << "/" << seq.capacity() << "] ";
	for (size_t pos = 0; pos < seq.size(); pos += 1) {
		std::cout << seq[pos] << " ";
	}
	std::cout << std::endl;
}

template<typename T>
void Sequence<T>::recap(std::size_t n) {
	if (this->_cap == n) {
		return; // nichts zu tun
	}
	this->_cap = n;
	T *new_array = new T[this->_cap];
	std::size_t idx = 0;
	while ((idx < this->_cap && idx < this->_size)) {
		new_array[idx] = this->_array[idx];
		idx += 1;
	}
	delete[] this->_array;
	this->_array = new_array;
	if (this->_size > this->_cap) {
		this->_size = this->_cap;
	}
}
template<typename T>
void Sequence<T>::grow_on_demand() {
	if (this->_size == this->_cap) { // voll
		std::size_t new_cap = (this->_cap * 2); // verdopple Kapazität
		recap(new_cap);
	}
}

#endif
