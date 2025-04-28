#include<thread>
#include<iostream>
#include "producer.h"
#include "consumer.h"
#include "queue_cv.h"
#include "sleep.h"

static const int MAX = 100;
static const int QSIZE = 5;

using namespace std;

int main() {
  Queue_cv queue(QSIZE);

  /* start producer with positive values */
  Producer p(&queue, MAX, 1);
  thread t1(&Producer::produce, &p);

  /* start producer with negative values */
  Consumer c(&queue, MAX);
  thread t2(&Consumer::consume, &c);

  /* wait for producer and consumer */
  t1.join();
  t2.join();
}
