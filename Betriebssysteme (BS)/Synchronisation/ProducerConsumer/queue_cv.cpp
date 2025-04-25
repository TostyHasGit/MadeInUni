#include "queue_cv.h"
using namespace std;

Queue_cv::Queue_cv(size_t cap) : Queue(cap) {
}

void Queue_cv::put(const int& ele) {
  unique_lock<mutex> ul(m);
  while(is_full()) {
    notfull.wait(ul);
  }
  Queue::put(ele);
  notempty.notify_one();
}

int Queue_cv::get() {
  unique_lock<mutex> ul(m);
  while(is_empty()) {
    notempty.wait(ul);
  }
  int ret = Queue::get();
  notfull.notify_one();
  return ret;
}

