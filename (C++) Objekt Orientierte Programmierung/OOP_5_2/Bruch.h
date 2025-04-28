#ifndef BRUCH_H_
#define BRUCH_H_
#include <iostream>

class Bruch {
public:
	Bruch(int zaehler, int nenner);
	~Bruch();
	int zaehler() const;
	int nenner() const;
	bool operator==(const Bruch& a) const;
	bool operator!=(const Bruch& a) const;
	Bruch& operator*=(const Bruch& a);

private:
	int _zaehler;
	int _nenner;
};
inline Bruch operator*(const Bruch& a, const Bruch& b){
		Bruch br(a.zaehler() * b.zaehler(), a.nenner() * b.nenner());
		return br;
	}
inline Bruch operator*(const Bruch& a, int b){
		Bruch br(a.zaehler() * b, a.nenner() * b);
				return br;
	}
inline Bruch operator*(int a, const Bruch& b){
		Bruch br(b.zaehler()* a, b.nenner() * a);
				return br;
	}

inline int ggt2(int x, int y){
	int z;
	while(z != 0)
	{
		x = x%y;
		z = x;
		x = y;
		y = z;
	}
	return x;
}

#endif
