#ifndef VAL_H_
#define VAL_H_

class A {
public:
	A(): _val{17}{
	}
	A(int val):_val{42}{
		_val = val;
	}
	int get_val() const {
		return _val;
	}
	int& get_val() {
		return _val;
	}

private:
	int _val;

};
#endif
