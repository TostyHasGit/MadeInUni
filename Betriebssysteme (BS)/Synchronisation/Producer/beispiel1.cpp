#include<thread>
#include<iostream>
#include "producer.h"
#include "queue.h"
#include "sleep.h"

static const int MAX = 100;

using namespace std;

int main() {
  Queue queue(MAX);
  Producer p1(&queue, MAX/2, 1);
  Producer p2(&queue, MAX/2, -1);
  
  init_sleep();
  /* start producer with positive values */
  thread t1(&Producer::produce, &p1);  // p1.produce()

  /* start producer with negative values */
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
