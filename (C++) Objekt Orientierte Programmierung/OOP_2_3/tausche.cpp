#include "tausche.h"

void tausche(int*&a, int*&b){

	int *temp = a;
	a = b;
	b = temp;
}


