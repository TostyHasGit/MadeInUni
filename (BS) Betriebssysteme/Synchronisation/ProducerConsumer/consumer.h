#ifndef CONSUMER_H
#define CONSUMER_H

#include "queue.h"


class Consumer {
public:
  Consumer(Queue* queue,  int anzahl);
  void consume();
private:
  int anzahl;  
  Queue* queue;
};

#endif
