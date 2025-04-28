#include "flexqueue.h"
using namespace std;

int main() {

	Queue q;
	int capacity { 8 };
	q.queue_init(&q, capacity);
	for (int i { 0 }; i < 16; ++i) {
		q.queue_enter(&q, i);
	}
	q.queue_show(&q);

	for (int i { 0 }; i < 15; ++i) {
		q.queue_leave(&q);
		cout << "cap:" << q.cap << " head:" << q.head << " tail:" << q.tail << endl;

	}
	q.queue_show(&q);

//	for (int i { 0 }; i < 15; ++i) {
//		q.queue_enter(&q, i);
//	}
//	q.queue_show(&q);
//	for (int i { 0 }; i < 300; ++i) {
//		q.queue_leave(&q);
//	}
	q.queue_show(&q);

//	q.queue_leave(&q);
//	q.queue_leave(&q);
//	q.queue_leave(&q);
//	q.queue_leave(&q);
//	q.queue_leave(&q);
//	q.queue_leave(&q);
//	q.queue_leave(&q);
//	q.queue_leave(&q);
//	q.queue_leave(&q);
//	q.queue_leave(&q);
//	q.queue_enter(&q, 8);
//	q.queue_enter(&q, 9);
//	q.queue_enter(&q, 10);
//	q.queue_enter(&q, 11);
//	q.queue_leave(&q);
//	q.queue_leave(&q);
//	q.queue_leave(&q);
//	q.queue_enter(&q, 12);
//	q.queue_enter(&q, 13);
//	q.queue_enter(&q, 14);
//	q.queue_enter(&q, 15);
//	q.queue_enter(&q, 16);
//	q.queue_enter(&q, 17);
//	q.queue_enter(&q, 18);
//	q.queue_enter(&q, 17);
//	q.queue_enter(&q, 18);
//	q.queue_enter(&q, 19);
//	q.queue_enter(&q, 20);
//	q.queue_enter(&q, 21);

//	for(size_t i{0}; i < q.cap; ++i){
//			cout << q.arr[i] << " ";
//		}



}
