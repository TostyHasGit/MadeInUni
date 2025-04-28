#include <iostream>
#include "KVT.h"
using namespace std;

void out(KVT kvt){
	cout << kvt.val << " " << endl;
}

int main(){
	out(1);
	out((short)1);
	out(1.0f);
	out(3.1415);
	out('x');
	cout << endl;
}
