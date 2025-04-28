#include "pbma.h"
using namespace std;

int main(int argc, const char* argv[]){
	args_t args(argc, argv);
	vector<string> fname = args.positionals();
	vector<int> a = read_ints(fname[0]);
	int zaehler{0};
	int max{0};

	for(size_t i{0}; i < a.size(); ++i){
		++zaehler;
		if(i != a.size()){
			if(max < a[i]){
			max = a[i];
			}
		}
		else
			break;
	}
	cout << "Maximum: " << max << endl << "Anzahl: " << zaehler << endl;
}
