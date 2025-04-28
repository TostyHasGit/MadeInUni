#ifndef QUEUE_H_
#define QUEUE_H_
#include "pbma.h"

template<typename T>
class Queue {
public:
	Queue();
	Queue(const Queue&);
	Queue<T>& operator=(const Queue&);
	~Queue();
	void enter(const T& t);
	T leave();
	bool is_empty() const;
	std::size_t size() const;
	void show() const;
private:
	class Node {
		friend class Queue;
		Node* next;
		T val;
	};
	Node* head;
	Node* tail;
};

#include "Queue.cpp"
#endif /* QUEUE_H_ */
