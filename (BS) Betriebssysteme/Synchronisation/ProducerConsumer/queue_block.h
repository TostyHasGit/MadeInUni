#ifndef QUEUEBLOCK_H
#define QUEUEBLOCK_H

#include "queue.h"
#include <semaphore.h>

class Queue_block : public Queue {
public:
  Queue_block(size_t cap);
  void put(const int& ele);
  int get();
private:  
  sem_t mutex;
  sem_t empty;
  sem_t full;
};


#endif
