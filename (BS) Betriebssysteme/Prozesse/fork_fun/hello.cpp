#include <iostream>
#include <unistd.h>

using namespace std;

int main() {
  cout << "Hello ";
//  flush(cout);
  fork();
  cout << "World!" << endl;
}
