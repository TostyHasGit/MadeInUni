#include <iostream>
#include "pbma.h"
using namespace std;

BigInt pm(BigInt x){
	if(x < 0){return ++pm(++x);}

	if(x > 0){return --pm(--x);}

	return 0;
}

BigInt add(BigInt x, BigInt y){
	if(x > 0){
		for(int i{0}; i < x; i++){
			++y;
		}
	}

	if(x < 0){
		for(int i{0}; i > x; i--){
			y--;
		}
	}
	return y;

}
BigInt mult(BigInt x, BigInt y){
	if(x > 1 and y > 1){return add(y, mult(--x, y));}
	if(x < -1){return mult(pm(x),pm(y));}
	return 0;
}


int main(){
	cout << add(-5, -6) << endl;
	cout << mult(3, 5) << endl;
	cout << pm(10) << endl;

}
