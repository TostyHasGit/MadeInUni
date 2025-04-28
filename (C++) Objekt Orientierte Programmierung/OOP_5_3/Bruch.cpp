#include "Bruch.h"



Bruch::Bruch(int zaehler=0, int nenner=1){
	int x = ggt2(zaehler, nenner);
	_zaehler = zaehler / x;
	_nenner = nenner / x;
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

bool Bruch::operator==(const int a) const {
 	 if (_zaehler / _nenner == a ){
 		 return true;
 	 }
 	 else
 		 return false;
 }


 bool Bruch::operator!=(const Bruch& a) const{
	 return !(*this==a);
 }

 bool Bruch::operator!=(const int a) const {
	 if (!(_zaehler / _nenner == a)){
 		 return true;
 	 }
 	 else
 		 return false;
 }


 Bruch& Bruch::operator*=(int a){
 	 _zaehler *= a;
 	 return *this;
  }
 Bruch& Bruch::operator*=(Bruch& a){
	 _zaehler *= a.zaehler();
	 _nenner *= a.nenner();

	 return *this;
 }


