#include <thread>
#include <iostream>
#include <unistd.h>

using namespace std;

struct Buffer {
  int a;
  int b;
  int erg;
};

void add(Buffer* buf) {
  cout << "(Thread Nr. " << this_thread::get_id() << " Computing sum" << endl;
  buf->erg = buf->a + buf->b;
  sleep(20);
}


int main() {   
  Buffer buf;
  thread t1;

  cout << "(Thread Nr. " << this_thread::get_id() << endl;
  cout << "Enter two integer arguments: ";
  cin >> buf.a >> buf.b;

  t1 = thread(add, &buf);
 
  t1.join();

  cout << "(Thread Nr. " << this_thread::get_id() << " Result: " << buf.erg << endl;
  return 0;
}

