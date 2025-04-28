/*
 * main.cpp
 *
 *  Created on: 17.03.2023
 *      Author: n3004549
 */
#include <iostream>
#include "ggt.h"
#include "pbma.h"
#include <string>
#include <vector>
using namespace std;

int main(int argc, const char* argv[])
{
	args_t args(argc, argv);
	string fname = args.pos(0, "ggts.dat");
	Timer timer;
	vector<int> zahlen = read_ints(fname);
	cout << "lesen dauerte: " << timer.human_measure() << endl;

	for(int i{0}; i < sizeof(zahlen); i++)
	{
		cout << i+1 << " und " << i+2 << ":";
		cout << ggt1(zahlen[i], zahlen[i+1]) << " ";
		cout << ggt2(zahlen[i], zahlen[i+1]) << endl;

	}

}
