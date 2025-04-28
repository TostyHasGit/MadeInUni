#ifndef INTVEC_H_
#define INTVEC_H_
#include <iostream>

struct intvec{
	size_t capacity;
	size_t size;
	int *arr;
};

void ivec_init(intvec* ivec, size_t cap);
void ivec_clear(intvec* ivec);
void ivec_push_back(intvec* ivec, int ele);
int& ivec_at(intvec* ivec, size_t idx);
int ivec_sum(intvec* ivec);

#endif
