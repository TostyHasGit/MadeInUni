#ifndef SEQUENCE_H_
#define SEQUENCE_H_
#include "pbma.h"

template<typename T>
class Sequence {
public:
	Sequence(size_t cap = 1);
	Sequence(const Sequence&);
	Sequence& operator=(const Sequence&);
	~Sequence();
	size_t size() const;
	size_t capacity() const;
	void trim();
	bool is_empty() const;
	T& operator[](size_t pos);
	const T& operator[](size_t pos) const;
	void insert(size_t pos, const T &ele);
	void clear();
	void push_back(const T &ele);
	void remove(size_t pos);
	bool remove_ele(const T &ele);
	bool operator==(const Sequence&)const;

private:
	void recap(size_t size);
	void grow_on_demand();
	T *_array;
	size_t _cap;
	size_t _size;
};


#include "Sequence.cpp"
#endif
