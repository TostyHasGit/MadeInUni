#include <iostream>
#include <string>
#include <vector>
#include "pbma.h"
using namespace std;


int main(int argc, const char* argv[])
{
	args_t args(argc, argv);
	string fname = args.pos(0, "lena.pgm");
	string f_new = args.pos(1, "a.pgm");
	vector<int> bild = read_pgm(fname);

	double s = args.double_pos(2, 0.5);


	for(int i=3; i < bild.size(); i++)
	{
		if(bild[i] < (s*bild[2]))
		{
			bild[i] = 0;
		}
		else
			bild[i] = bild[2];

		cout << bild[i] << endl;
	}
	save_pgm(f_new, bild, 1);

}
