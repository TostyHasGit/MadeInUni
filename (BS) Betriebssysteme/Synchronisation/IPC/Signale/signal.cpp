#include<signal.h>
#include<iostream>

using namespace std;

void f(int s) {
	static int i = 0;
	cout << ++i << " mal CTRL + C gedrückt" << endl;
	if (i == 5) {
		cout << "exit" << endl;
		exit(0);
	}
}

int main() {
	signal(2, f);
	while(true);
}
