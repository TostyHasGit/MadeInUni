#include "intvec.h"
using namespace std;

void ivec_init(intvec* ivec, size_t cap)
{
	ivec->capacity = cap;
	ivec->arr = new int [cap]{};
	ivec->size = 0;

}

void ivec_clear(intvec* ivec)
{
	ivec->arr=nullptr;
	ivec->capacity = 0;
	ivec->size=0;
}

void ivec_push_back(intvec* ivec, int ele)
{
	if(ivec->size == ivec->capacity){
		intvec* new_ivec = new intvec;
		ivec->capacity *= 2;
		new_ivec->arr = new int[ivec->capacity];

		for(size_t i{0}; i < ivec->size;i++){
			new_ivec->arr[i] = ivec->arr[i];
		}
		ivec->arr[ivec->size] = ele;
		ivec->size += 1;
	}
	else{
		ivec->arr[ivec->size] = ele;
		ivec->size += 1;
	}
}

int& ivec_at(intvec* ivec, size_t idx)
{
	if(ivec->size < idx)
	{
		throw invalid_argument("Wert ist nicht initialisiert!");
	}
	else
		return ivec->arr[idx];
}

int ivec_sum(intvec* ivec)
{
	int sum = 0;

	for(int i=0; i < ivec->size; i++){
		sum += ivec->arr[i];
	}
	return sum;
}
