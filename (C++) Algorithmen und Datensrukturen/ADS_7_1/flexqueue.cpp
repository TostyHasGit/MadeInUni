#include "flexqueue.h"
using namespace std;

void Queue::queue_show(Queue *q) {
	cout << "cap:" << q->cap << " head:" << q->head << " tail:" << q->tail << endl;

	if (q->head == q->tail) {
			cout << "Array leer!" << endl;
		return;
	}

	if (q->head < q->tail) {
		for (size_t i { q->head }; i < q->tail; ++i) {
			cout << q->arr[i] << " ";
		}
		cout << endl;
	} else {
		for (size_t i { q->head }; i <= q->cap; ++i) {
			cout << q->arr[i] << " ";
		}
		for (size_t i { 0 }; i < q->tail; ++i) {
			cout << q->arr[i] << " ";
		}
		cout << endl;
	}
}
void Queue::queue_tausch(Queue *q, int *temp) {
	size_t j {0};
	if (q->head < q->tail) {

		for (size_t i { q->head }; i < q->tail; ++i) {
			temp[j] = q->arr[i];
			++j;
		}
	} else {
		for (size_t i { q->head }; i <= q->cap; ++i) {
			temp[j] = q->arr[i];
				++j;
		}
		for (size_t i { 0 }; i < q->tail; ++i) {
			temp[j] = q->arr[i];
			++j;
		}

	}
	q->tail = queue_abstand(q);
	delete[] q->arr;
	q->arr = temp;
	q->head = 0;

	cout << "Array neu angelegt: Head und Tail verschoben!" << endl;

}

size_t Queue::queue_abstand(Queue *q) {
	int count { 0 };
	if (q->head < q->tail) {
		for (size_t i { q->head }; i < q->tail; ++i) {
			count++;
		}
	} else {
		for (size_t i { q->head }; i < q->cap; ++i) {
			count++;
		}
		for (size_t i { 0 }; i <= q->tail; ++i) {
			count++;
		}
	}

	return count;
}

void Queue::reduzieren(Queue *q) {
	if (queue_abstand(q) < (q->cap / 4)) {
		if (q->cap / 2 < 8) {
			return;
		} else {
			int *temp = new int[q->cap / 2];
			queue_tausch(q, temp);
		}

		if (q->cap / 2 < 8) {
			q->cap = 8;
		} else
			q->cap /= 2;
	}
}

void Queue::queue_init(Queue *q, size_t cap) {
	q->cap = cap;
	q->arr = new int[q->cap + 1];
	q->head = 0;
	q->tail = 0;
}

void Queue::queue_clear(Queue *q) {
	delete[] q->arr;
	q->arr = nullptr;
	q->head = q->tail = q->cap = 0;
}

bool Queue::queue_is_empty(Queue *q) {
	return q->head == q->tail;
}

bool Queue::queue_is_full(Queue *q) {
	return (q->tail + 1) % (q->cap + 1) == q->head;
}

int Queue::queue_front(Queue *q) {
	if (queue_is_empty(q)) {
		throw runtime_error("queue_front: queue underflow");
	}
	return q->arr[q->head];
}

void Queue::queue_enter(Queue *q, int ele) {
	if (queue_is_full(q)) {
		int *temp = new int[q->cap * 2];
		queue_tausch(q, temp);
		q->cap *= 2;
		q->arr[q->tail] = ele;
		q->tail = (q->tail + 1) % (q->cap + 1);
		reduzieren(q);

	} else {
		q->arr[q->tail] = ele;
		q->tail = (q->tail + 1) % (q->cap + 1);
	}
}

int Queue::queue_leave(Queue *q) {
	if (queue_is_empty(q)) {
		throw runtime_error("queue_leave: queue underflow");
	}
	size_t retidx = q->head;
	q->head = (q->head + 1) % (q->cap + 1);
	reduzieren(q);


	return q->arr[retidx];
}

