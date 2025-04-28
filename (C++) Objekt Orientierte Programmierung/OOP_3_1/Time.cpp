#include "Time.h"

//Time& Time::init(int h, int m, int s){
//	hour = h;
//	minute = (m > 0 && m < 60 ? m : 0);
//	second = (s > 0 && s < 60 ? s : 0);
//}

void Time::add_hour(int a){
	hour = (hour + a > 0 && hour + a < 25 ? hour + a : 0);
}
void Time::add_minute(int a){
	minute = (minute + a > 0 && minute + a < 60 ? minute + a : 0);
}
void Time::add_second(int a){
	second = (second + a > 0 && second + a < 60 ? second + a : 0);
}
int Time::justseconds(){
	return hour*60 + minute*60 + second;
}

