#ifndef TIME_H_
#define TIME_H_
#include <iostream>

class Time {
private:
	int hour;
	int minute;
	int second;

public:
//	Time& init(int h, int m, int s);
	Time(int h, int m, int s){
		hour = (h > 0 && h < 25 ? h : 0);
		minute = (m > 0 && m < 60 ? m : 0);
		second = (s > 0 && s < 60 ? s : 0);
	}

	void add_hour(int a);
	void add_minute(int a);
	void add_second(int a);
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
