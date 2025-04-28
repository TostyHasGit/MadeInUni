#include "val.h"
#include <iostream>
using namespace std;

int main(){
	A a;
	A as[3];
	const A ca1; const A ca2 = 42;
	cout << a.get_val() << endl;
	a.get_val() = 42;
	cout << as[2].get_val() << endl;
	cout << a.get_val() << endl;
	cout << ca1.get_val() << " " << ca2.get_val() << endl;
}
