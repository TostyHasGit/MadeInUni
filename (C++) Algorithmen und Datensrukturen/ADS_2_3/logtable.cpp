#include <iostream>
#include <cmath>
#include "pbma.h"
#include <string>
using namespace std;

int main(int argc, const char* argv[]){
	args_t args(argc, argv);
	double s = args.double_option("start", 1);
	double a = args.double_option("step", 0);
	double b = args.double_option("base", 0);
	int e = args.int_pos(5, 0);
//	int p = args.int_option()
	cout << "logtable" <<  " base=" << b << " start=" << s << " step=" << a << " " << e << " elements" << endl;

	double l = log(s)/log(b);
	cout << s << " : " << l << endl;

	for(int i{0}; i < e; i++){
		s += a;
		l = log(s)/log(b);
		cout << s << " : "<< l << endl;
	}


}
