#include <iostream>
#include "pbma.h"
#include <vector>
#include <string>
using namespace std;

int main(int argc, const char* argv[])
{
	args_t args(argc, argv);
	string fname = args.pos(0, "zahlen.dat");
	vector<int> zahlen = read_ints(fname);
	int kleinstezahl = zahlen[0];

	cout << "Es sind " << zahlen.size() << " Zahlen" << endl;

	for(int i=0; i<zahlen.size(); i++)
	{
		if(kleinstezahl>zahlen[i])
		{
			kleinstezahl=zahlen[i];
		}
	}
	cout << "Die kleinste Zahl ist: " << kleinstezahl;
}


