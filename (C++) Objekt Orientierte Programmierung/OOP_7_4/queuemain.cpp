#include "Queue.h"
using namespace std;

int main() {
	Queue<int> a;
	for (size_t i { 0 }; i < 10; ++i) {
		a.enter(i);
	}
	a.show();
//	for (size_t i { 0 }; i < 5; ++i) {
//		a.leave();
//	}
//	a.show();
//	for (size_t i { 0 }; i < 3; ++i) {
//		a.enter(i);
//	}
//	a.show();
//
//	Queue<int> b;
//	for (size_t i { 0 }; i < 10; ++i) {
//		b.enter(i);
//	}
//
//	b.show();
//	a = b;
//	a.show();
}
