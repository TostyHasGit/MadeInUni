#include <iostream>
#include <vector>
#include <string>
#include "pbma.h"
using namespace std;


int main(int argc, const char* argv[]){
	args_t args(argc, argv);
	vector<string> namen;

	for(int i=0; i<(argc-1); i++){

		namen.push_back(args.pos(i));
	}

	cout << "Wir Fangen an bei: " << namen[0] << endl;

	int i{0};
	int k{0};

	while(namen.size() != 1){


		if(i == 7){
			cout << namen[k-1] << " ist Rausgeflogen" << endl;
			namen.erase(begin(namen) + k-1);
			i = 0;
			k = 0;
		}

		k++;

		if(k > namen.size()){
			k = 0;
		}
		else
			i++;
	}

	cout << "Gewonnen hat: " << namen[0];
}
