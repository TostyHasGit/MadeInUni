#include <iostream>
#include "at.h"
#include "alltest.h"
using namespace std;

int& at(int* vec, int len, int i){

	if(vec[i]){
		int &a = vec[i];
		return a;
	}
	else{
		throw runtime_error("Index Overflow");
	}

}
