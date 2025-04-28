#include "pbma.h"
using namespace std;

int main(int argc, const char* argv[]){
	args_t args(argc, argv);
	vector<string> fname = args.positionals();


	for(size_t i{0}; i < fname.size(); ++i){
		vector<int> a = read_ints(fname[i]);
		cout << a[1];
	}


}
