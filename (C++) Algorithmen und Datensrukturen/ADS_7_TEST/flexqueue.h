#ifndef FLEXQUEUE_H_
#define FLEXQUEUE_H_
#include "pbma.h"

struct Queue {
	int* arr;
	size_t cap;
	size_t head;
	size_t tail;

	void queue_show(Queue* q);
	void queue_tausch(Queue *q, int* temp);
	int queue_abstand(Queue* q);
	void reduzieren(Queue* q);
	void queue_init(Queue* q, size_t cap);
	void queue_clear(Queue* q);
	bool queue_is_empty(Queue* q);
	bool queue_is_full(Queue* q);
	int queue_front(Queue* q);
	void queue_enter(Queue* q, int ele);
	int queue_leave(Queue* q);

};

#endif /* FLEXQUEUE_H_ */
