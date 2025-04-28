#include <iostream>
#include "Bruch.h"
using namespace std;

int main(){
	Bruch v(4, -2);

	cout << v.zaehler() << "/" << v.nenner();

	Bruch b = 2 * Bruch(15, 4);
}
