#ifndef LINE_H_
#define LINE_H_
#include "Point.h"

class Line{
public:
	Line(Point start, Point end)
	: _start(start), _end(end){}
	~Line()=default;

	Point get_start() const{
		return _start;
	}
	Point get_end() const{
		return _end;
	}

	void operator+=(const Point& a){
			_start += a;
			_end += a;
		}

	bool operator==(const Line& a){
		if ( _start == a.get_start() and _end == a.get_end()){
			return true;
		}
		else
			return false;
	}


private:
	Point _start;
	Point _end;
};



#endif /* LINE_H_ */
