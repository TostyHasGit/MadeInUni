#include <iostream>
#include <thread>
#include "producer.h"
#include "queue.h"
#include "sleep.h"


using namespace std;

Producer::Producer(Queue* queue, int anzahl, int factor) : queue(queue), factor(factor), anzahl(anzahl) {
  init_sleep();
}

void Producer::produce() {
  for (int i = 1; i <= anzahl; i++) {
    bool success = false;
    while (!success) {
      try{
        queue->put(i * factor);
        success = true;
      } catch(...) {
        cerr << "Thread " << this_thread::get_id() << " found full queue full" << endl;
      }
      /* sometimes delay process  */
      rand_sleep(5000);
    }
  }
}

