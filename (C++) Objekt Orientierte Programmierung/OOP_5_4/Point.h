#ifndef POINT_H_
#define POINT_H_
#include "pbma.h"

class Point{
public:
	Point(int x, int y)
		:_x(x), _y(y){
	}
	~Point()=default;

	int get_x() const{
		return _x;
	}
	int get_y() const{
		return _y;
	}

	void operator+=(const Point& a){
		_x += a.get_x();
		_y += a.get_y();
	}
	bool operator==(const Point& a){
		if ( _x == a.get_x() and _y == a.get_y()){
			return true;
		}
		else
			return false;
		}


private:
	int _x{0};
	int _y{0};
};



#endif /* POINT_H_ */
