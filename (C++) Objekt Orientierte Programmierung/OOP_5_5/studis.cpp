#include "Studi.h"
#include "pbma.h"
using namespace std;

int main(){
	vector<Studi> a;
	vector<long> b = read_longs("studis.txt");
	vector<string> c = read_words("studis.txt");
	int s = 1;

	for(size_t i{0}; i < b.size(); ++i){
		Studi d(b[i], c[s], c[s+1]);
		d.get_studi();
		a.push_back(d);
		s+=3;
	}
}
