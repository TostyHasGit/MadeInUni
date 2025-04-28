#include<thread>
#include<iostream>
#include "producer.h"
#include "queue_sync.h"
#include "sleep.h"

static const int MAX = 100;

using namespace std;

int main() {
  Queue_sync queue(MAX);

  /* start producer with positive values */
  Producer p1(&queue, MAX/2, 1);
  thread t1(&Producer::produce, &p1);

  /* start producer with negative values */
  Producer p2(&queue, MAX/2, -1);
  thread t2(&Producer::produce, &p2);

  /* wait for producers */
  t1.join();
  t2.join();

  /* output queue contents */
  cout << "Anzahl: " << queue.size() << endl;
  cout << "Inhalt:" << endl;

  while(!queue.is_empty()) {
    cout << queue.get() << " ";
  }
  cout << endl;
}
