#include "linkedqueue.h"
using namespace std;


void lqueue_enter(singlelinked_queue* lq, string s){
	linked_queue* n = new linked_queue;
	n->next = nullptr;
	n->val = s;
	if(lq->head == nullptr){
		lq->head = n;
		return;
	}
	linked_queue* h = lq->head;
	while(h->next != nullptr){
		h = h->next;
	}
	h->next = n;
}
string lqueue_leave(singlelinked_queue* lq){
	if(lq->head == nullptr){
		return "manjak";
	}
	linked_queue* to_del = lq->head;
	string deleted = to_del->val;
	lq->head = lq->head->next;
	delete to_del;
	return deleted;

}
bool lqueue_is_empty(singlelinked_queue* lq){
	return lq->head == nullptr;

}
size_t lqueue_size(singlelinked_queue* lq){
	if(lq->head == nullptr){
		return 0;
	}
	int anzahl = 1;
	linked_queue* count = lq->head;
	while(count->next != nullptr){
		anzahl ++;
		count = count->next;
	}
	return anzahl;
}
