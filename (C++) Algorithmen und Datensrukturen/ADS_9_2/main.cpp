#include "hashmapv.h"
using namespace std;

int main(int argc, const char* argv[]){
	args_t args(argc, argv);
	string file = args.pos(0, "atwi80d.txt");
	vector<string> words = read_words(file);
}
