// Wieviele A werden ausgegeben?
#include <iostream>
#include <unistd.h>
#include <wait.h>

using namespace std;

int main() {
  pid_t mypid = getpid();
  pid_t wait_pid;
  for (int i = 0; i < 2; i++) {
    fork();
    if (getpid() == mypid)
     cout << getpid() << " father of all: " << "A" << endl;
    else
     cout << getpid() << " forked by " << getppid() << ": " << "A" << endl;
  }
 
  if(mypid == getpid()) {
	  wait_pid= wait(nullptr);
	  wait_pid= wait(nullptr);
} 
  cout << getpid() << " terminated" << endl;
  return 0;
}
