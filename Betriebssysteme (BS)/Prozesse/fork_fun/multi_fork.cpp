// Wieviele A werden ausgegeben?
#include <iostream>
#include <unistd.h>
#include <wait.h>

using namespace std;

int main() {
  pid_t mypid = getpid();
  for (int i = 0; i < 3; i++) {
    fork();
    cout << "A" << endl;
  }
  if(mypid == getpid()) wait(nullptr);
  return 0;
}
