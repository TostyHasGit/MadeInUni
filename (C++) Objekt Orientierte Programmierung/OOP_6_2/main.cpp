#include "CommonVector.h"
#include <cmath>
using namespace std;


int main(){
	CommonVector<int, 10> a;
	for(size_t i{0}; i < a.size(); ++i){
		a[i] = pow(i, 2);
	}

	CommonVector<char, 25> b;

	string s = "Hallo tolle C++ Welt";
	for(size_t i{0}; i < 20; ++i){
		b[i] = s[i];
	}

//	CommonVector<char*, 25> c;
//	c[0] = "Hallo";
//	c[1] = "tolle";
//	c[2] = "C++";
//	c[3] = "Welt";
	a.out();
	cout << endl;
	b.out();


}
