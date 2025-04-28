#include <iostream>
#include <cmath>
#include "pbma.h"
using namespace std;


int main(int argc, const char* argv[])
{

	args_t args(argc, argv);
	double x = args.double_pos(0, 10.0);
	double eps = args.double_pos(1, 1e-6);

	cout << "x:"<< x << endl;
	cout << sqrt(x) << endl;
	double a;
	double i = ((1+x)/2);

	while(i)
	{
		a = ((i+(x/i))/2);

		if ( (i-a) > eps)
		{
			i = a;
		}
		else
			break;
	}
	cout << i << endl;
}
