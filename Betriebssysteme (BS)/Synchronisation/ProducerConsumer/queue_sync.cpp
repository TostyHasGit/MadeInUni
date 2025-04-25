#include "queue_sync.h"
#include <semaphore.h>

Queue_sync::Queue_sync(size_t cap) : Queue(cap) {
  sem_init(&mutex, 0, 1);
}

void Queue_sync::put(const int& ele) {
  sem_wait(&mutex);
  try {
    Queue::put(ele);
  } catch(...) {
    sem_post(&mutex);
    throw;
  }
  sem_post(&mutex);
}

int Queue_sync::get() {
  sem_wait(&mutex);
  int ret = 0;
  try {
    ret = Queue::get();
  } catch(...) {
    sem_post(&mutex);
    throw;
  }
  sem_post(&mutex);
  return ret;
}

