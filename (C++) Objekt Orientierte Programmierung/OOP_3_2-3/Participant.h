#ifndef PARTICIPANT_H_
#define PARTICIPANT_H_
#include <iostream>
#include <vector>
#include <string>
#include "Time.h"

class Participant {
public:
	static int anzahl;
	Participant(std::string name, Time time){
		_name = name;
		_time = time;
		Participant::anzahl++;
	}
	std::string get_name();
	void get_time();
	Time get_time2();
	static int get_anzahl();

	~Participant(){
		Participant::anzahl--;
	}
private:
	std::string _name;
	Time _time;
};


#endif
