#include <iostream>
#include "Time.h"
using namespace std;

int main(){
	Time zeit(22, 7, 44);
	Time zeit2(6, 36, 9);
// 	zeit.init(24, 7, 44);
//	zeit.add_hour(5);
//	zeit.add_minute(18);
//	zeit.add_second(20);
	Time a = add(zeit, zeit2);
	Time d = diff(zeit, zeit2);
	cout<< zeit.get_hour() << ":"
		<< zeit.get_minute() << ":"
		<< zeit.get_second() << " in Sekunden: "
		<< zeit.justseconds() << endl
		<< "Zeiten zusammengerechnet: "
		<< a.get_hour() << ":"
		<< a.get_minute() << ":"
		<< a.get_second() << endl
		<< "Zeiten abgezogen: "
		<< d.get_hour() << ":"
		<< d.get_minute() << ":"
		<< d.get_second() << endl;

}
