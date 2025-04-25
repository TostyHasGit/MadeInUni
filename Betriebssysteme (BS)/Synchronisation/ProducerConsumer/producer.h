#ifndef PRODUCER_H
#define PRODUCER_H

#include "queue.h"

class Producer {
public:
  Producer(Queue* queue, int anzahl, int factor);
  void produce();
private:
  Queue* queue;
  int factor;
  int anzahl; 
};

#endif
