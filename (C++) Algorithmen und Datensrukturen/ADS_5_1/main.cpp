#include <iostream>
#include "pbma.h"
using namespace std;

int algo(vector<int> a){
	int max{0};
	int aktuell{0};

	for(int i{0}; i < a.size(); i++){
		aktuell = aktuell + a[i];

		if(aktuell < 0){
			aktuell = 0;
		}
		if(max < aktuell){
			max = aktuell;
		}
	}
	return max;
}

int main(int argc, const char* argv[]){
	args_t args(argc, argv);
	string fname = args.pos(0, "maxsubsimple.dat");
	string fname1 = args.pos(0, "maxsub.dat");
	string fname2 = args.pos(0, "maxsublarge.dat");
	string fname3 = args.pos(0, "maxsubverylarge.dat");

	vector<int> zahlen = read_ints(fname);
	vector<int> zahlen1 = read_ints(fname1);
	vector<int> zahlen2 = read_ints(fname2);
	vector<int> zahlen3 = read_ints(fname3);


	cout << algo(zahlen) << endl;
	cout << algo(zahlen1) << endl;
	cout << algo(zahlen2) << endl;
	cout << algo(zahlen3) << endl;


}
