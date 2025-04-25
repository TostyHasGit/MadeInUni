#ifndef QUEUEBLOCK_H
#define QUEUEBLOCK_H

#include "queue.h"
#include <mutex>
#include <condition_variable>

class Queue_cv : public Queue {
public:
  Queue_cv(size_t cap);
  void put(const int& ele);
  int get();
private:  
  std::mutex m;
  std::condition_variable notempty;
  std::condition_variable notfull;
};


#endif
