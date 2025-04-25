#ifndef QUEUESYNC_H
#define QUEUESYNC_H

#include "queue.h"
#include <semaphore.h>

class Queue_sync : public Queue {
public:
  Queue_sync(size_t cap);
  void put(const int& ele);
  int get();
private:  
  sem_t mutex;
};


#endif
