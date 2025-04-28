#include "IntVector.h"
#include "pbma.h"
#include <string>
using namespace std;

void klappt(IntVector& a){
	for(size_t i{0}; i < a.size(); i++){
		a[i] = i;
	}
	a.out();
	for(size_t i{2}; i < a.size(); ++i){
		if (i%2 == 0) {
			a[i] += 42;
		}
	}
	a.out();
}
void crash(IntVector& a) {
	cout << "crash" << endl;
	for(size_t i{0}; i < a.size(); i++){
		a[i] = i;
	}
	cout << a[42] << endl;
	a.out();
}

int main(int argc, const char* argv[]){
	args_t args(argc, argv);
	IntVector a(17);
	a.out();
	klappt(a);

	if (args.flag("crash")) {
		crash(a);
	}
}
