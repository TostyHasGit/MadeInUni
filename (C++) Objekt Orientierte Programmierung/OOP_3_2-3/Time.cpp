#include "Time.h"
using namespace std;

void Time::add_hour(int a){
	hour *= a;
}
void Time::add_minute(int a){
	minute = (minute + a > 0 && minute + a < 60 ? minute + a : 0);
}
void Time::add_second(int a){
	second = (second + a > 0 && second + a < 60 ? second + a : 0);
}
void Time::show(){
	cout << hour << ":" << minute << ":" << second << endl;
}
int Time::justseconds(){
	return hour*60 + minute*60 + second;
}

