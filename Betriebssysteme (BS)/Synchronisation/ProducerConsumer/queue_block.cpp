#include "queue_block.h"
#include <semaphore.h>
#include<unistd.h>
Queue_block::Queue_block(size_t cap) : Queue(cap) {
  sem_init(&mutex, 0, 1);
  sem_init(&empty, 0, cap);
  sem_init(&full, 0, 0);
}

void Queue_block::put(const int& ele) {
 // sleep(1);
  sem_wait(&empty);
  sem_wait(&mutex);
  Queue::put(ele);
  sem_post(&mutex);
  sem_post(&full);
}

int Queue_block::get() {
  sem_wait(&full);
  sem_wait(&mutex);
  int ret = Queue::get();
  sem_post(&mutex);
  sem_post(&empty);
  return ret;
}

