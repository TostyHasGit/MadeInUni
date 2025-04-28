#include <iostream>
#include <unistd.h>

using namespace std;

int global = 4;

int main() {
  if (fork() == 0) {
    global++;
  } else
    sleep(1);
  cout << "Prozess " << getpid() << ": global == " << global << endl;
}
