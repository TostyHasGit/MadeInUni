#include <unistd.h> // für POSIX-Systemaufrufe
#include <cstdlib>

int main() {
  const char* hello = "Hello World!\n";
  write(1,hello,13);
  exit(0); // kommentar
} 


