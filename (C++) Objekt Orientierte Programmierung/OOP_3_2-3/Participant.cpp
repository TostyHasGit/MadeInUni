#include "Participant.h"
using namespace std;

string Participant::get_name(){
	return _name;
}
void Participant::get_time(){
	_time.show();
}
Time Participant::get_time2(){
		return _time;
}
int get_anzahl(){
	return Participant::anzahl;
}
int Participant::anzahl=0;
