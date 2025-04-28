#include "Queue.h"

#ifndef QUEUE_CPP
#define QUEUE_CPP

template<typename T>
Queue<T>::Queue(){
	head = new Node;
	tail = new Node;
	head->next = nullptr;
}

template<typename T>
Queue<T>::Queue(const Queue& other){
	head = new Node;
	tail = new Node;
	head->next = nullptr;
	Node* h = other.head->next;
	while(h != nullptr){
		enter(h->val);
		h = h->next;
	}
}

template<typename T>
Queue<T>& Queue<T>::operator=(const Queue& other) {
	Queue tmp{other};
	head = tmp.head->next;
	tail = tmp.tail;
	return* this;
}

template<typename T>
Queue<T>::~Queue(){
	delete head;
}

template<typename T>
void Queue<T>::enter(const T &t) {
	Node *n = new Node;
	n->next = head->next;
	n->val = t;
	head->next = n;
	tail = head->next;
}

template<typename T>
T Queue<T>::leave() {
//	if (is_empty()) {
//		throw std::runtime_error("leer");
//	}
//	Node *todelete = head->next;
//	head->next = todelete->next;
//	delete todelete;
	Node* temp = head->next;
	delete head;
	head = new Node;
	head = temp;


}

template<typename T>
bool Queue<T>::is_empty() const {
	return head == tail;
}

template<typename T>
std::size_t Queue<T>::size() const {
	Node *h = head;
	size_t size = 0;
	while (h != nullptr) {
		h = h->next;
		size += 1;
	}
	return size;
}

template<typename T>
void Queue<T>::show() const{
	Node* h = head;
	while(h != nullptr){
		std::cout << h->val << " ";
		h = h->next;
	}
	std::cout << std::endl;
}

#endif
