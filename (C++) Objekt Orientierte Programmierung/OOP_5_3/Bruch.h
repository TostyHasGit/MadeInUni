#ifndef BRUCH_H_
#define BRUCH_H_
#include <iostream>

class Bruch {
public:
	Bruch(int zaehler, int nenner);
	~Bruch()=default;
	int zaehler() const;
	int nenner() const;
	bool operator==(const Bruch& a) const;
	bool operator==(const int a) const;
	bool operator!=(const Bruch& a) const;
	bool operator!=(const int a) const;
	Bruch& operator*=(int a);
	Bruch& operator*=(Bruch& a);

private:
	int _zaehler;
	int _nenner;
};
inline int ggt2(int x, int y){
	int z;
	while(y != 0)
	{
		x = x%y;
		z = x;
		x = y;
		y = z;
	}
	return x;
}

inline bool operator==(const int a, const Bruch& b) {
	 if (a == b.zaehler() / b.nenner() ){
		 return true;
	 }
	 else
		 return false;
}



inline bool operator!=(const int a, const Bruch& b){
	 if (!(a == b.zaehler() / b.nenner())){
		 return true;
	 }
	 else
		 return false;
}

inline Bruch operator*(const Bruch& a, const Bruch& b){
		Bruch br(a.zaehler() * b.zaehler(), a.nenner() * b.nenner());
		return br;
	}
inline Bruch operator*(const Bruch& a, int b){
		Bruch br(a.zaehler() * b, a.nenner());
				return br;
	}
inline Bruch operator*(int a, const Bruch& b){
		Bruch br(a* b.zaehler(), b.nenner());
				return br;
	}



#endif
