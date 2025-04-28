#include "Bruch.h"



Bruch::Bruch(int zaehler, int nenner){
	int x = ggt2(zaehler, nenner);
	_zaehler = zaehler / x;
	_nenner = nenner / x;
}

Bruch::~Bruch() {
}

 int Bruch::zaehler() const{
	 return _zaehler;
}

 int Bruch::nenner() const{
	 return _nenner;
}
 bool Bruch::operator==(const Bruch& a) const
		 {
	 if (_zaehler == a.zaehler() && _nenner == a.nenner()){
		 return true;
	 }
	 else
		 return false;

 }
 bool Bruch::operator!=(const Bruch& a) const{
	 return !(*this==a);

 }
 Bruch& Bruch::operator*=(const Bruch& a){
	 _zaehler *= a.zaehler();
	 _nenner *= a.nenner();

	 return *this;
 }


