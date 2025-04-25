#include <iostream>
#include <future>
#include <thread>

using namespace std;

struct Buffer {
  int a;
  int b;
};

int add(Buffer* buf) {
  cout << "(Thread Nr. " << this_thread::get_id() << " Computing sum" << endl;
  int erg = buf->a + buf->b;
  return erg;
}


int main() {
  Buffer buf;

  cout << "(Thread Nr. " << this_thread::get_id() << endl;
  cout << "Enter two integer arguments: ";
  cin >> buf.a >> buf.b;

  std::future<int> ret = std::async(add, &buf);
  int erg = ret.get();
 
  cout << "(Thread Nr. " << this_thread::get_id() << " Result: " << erg << endl;
  return 0;
}

