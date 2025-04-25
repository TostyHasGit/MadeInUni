#include <sys/types.h> // pid_t
#include <unistd.h> // fork
#include <cstdlib> // exit

int main() {
  switch (fork())
  {
    case -1 : exit(-1);
    case 0  : while(1);
    default : exit(0);
  }
}
