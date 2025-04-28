#include "queue.h"
#include "sleep.h"
#include "consumer.h"
#include <iostream>
#include <thread>

using namespace std;

Consumer::Consumer(Queue* queue, int anzahl) : queue(queue), anzahl(anzahl) {}

void Consumer::consume() {
  /* consume int values */
  for (int i = 1; i <= anzahl; i++) {
    int el = 0;
    bool success = false;
    while (!success) {
      try{
        el = queue->get();
        success = true;
      } catch(...) {
        cerr << "Task " << this_thread::get_id() << " found queue empty" << endl;
      }
    }
    cout << el << " ";
  }
  cout << endl;
}

