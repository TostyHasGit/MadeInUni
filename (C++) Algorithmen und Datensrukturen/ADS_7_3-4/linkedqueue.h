#ifndef LINKEDQUEUE_H_
#define LINKEDQUEUE_H_
#include "pbma.h"
#include <string>

struct linked_queue {
	std::string val;
	struct linked_queue* next;
};
struct singlelinked_queue{
	linked_queue* head = nullptr;
	linked_queue* tail = nullptr;
};
	void lqueue_enter(singlelinked_queue* lq, std::string s);
	std::string lqueue_leave(singlelinked_queue* lq);
	bool lqueue_is_empty(singlelinked_queue* lq);
	size_t lqueue_size(singlelinked_queue* lq);



#endif /* LINKEDQUEUE_H_ */
