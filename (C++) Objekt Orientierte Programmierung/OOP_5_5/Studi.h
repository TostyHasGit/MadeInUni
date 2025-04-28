#ifndef STUDI_H_
#define STUDI_H_
#include "pbma.h"

class Studi {
public:

	Studi()
		: _matnr(0000000), _vorname("???"), _nachname("???"){
	}
	Studi(long matnr, std::string vorname, std::string nachname)
		: _matnr(matnr), _vorname(vorname), _nachname(nachname){
	}

	void get_studi() const{
		std::cout << _matnr << " " << _vorname << " " << _nachname << std::endl;
	}
	long get_matnr() const{	return _matnr;}
	std::string get_vorname() const{	return _vorname;}
	std::string get_nachname() const{	return _nachname;}
	friend std::istream& operator>>(std::istream& in, Studi& s);

private:
	long _matnr;
	std::string _vorname;
	std::string _nachname;
};

inline std::ostream& operator<<(std::ostream& out, Studi a){
	out << a.get_matnr() << " " << a.get_vorname() << " " << a.get_nachname() << "\n";
	return out;
}
std::istream& operator>>(std::istream& in, Studi& s){
	long matnr;
	std::string vn;
	std::string nn;
	in >> matnr >> vn >> nn;
	s = Studi(matnr,vn,nn);
	return in;
}


#endif
