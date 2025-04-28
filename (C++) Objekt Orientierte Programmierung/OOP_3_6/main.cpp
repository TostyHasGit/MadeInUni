#include <iostream>
#include <string>
using namespace std;

class Del{
public:
	string arr[3];
	Del(string a = "a", string b = "b", string c = "c"){
		arr[0] = a;
		arr[1] = b;
		arr[2] = c;
	}
};


void out(const Del& del){
	cout << del.arr[0] << del.arr[1] << del.arr[2] << " ";
}

int main(){
	Del d1;
	Del d2("X");
	Del d3("X", "Y");
	Del d4("X", "Y", "Z");
	out(d1); out(d2); out(d3); out(d4);
	cout << endl;
}
