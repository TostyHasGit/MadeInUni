#ifndef TIME_H_
#define TIME_H_
#include <iostream>

class Time {
private:
	int hour;
	int minute;
	int second;

public:
	Time(int h=0, int m=0, int s=0){
		hour = h;
		minute = m;
		second = s;
	}

	void add_hour(int a);
	void add_minute(int a);
	void add_second(int a);
	void show();
	int justseconds();

	int get_hour()const{
		return hour;
	}
	int get_minute()const{
		return minute;
	}
	int get_second()const{
		return second;
	}



};

inline Time add(Time a, Time b){
	Time c(a.get_hour() + b.get_hour(), a.get_minute() + b.get_minute(), a.get_second() + b.get_second());
	return c;
}
inline Time diff(Time a, Time b){
	Time c(a.get_hour() - b.get_hour(), a.get_minute() - b.get_minute(), a.get_second() - b.get_second());
		return c;
}

#endif
