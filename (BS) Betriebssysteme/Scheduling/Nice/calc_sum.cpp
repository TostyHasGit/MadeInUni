#include <iostream>
#include <cstdlib>
#include <unistd.h>

using namespace std;

int main(int argc, const char *argv[]) {
  double sum = 0.0;
  int i, j;

  if (argc != 2) {
    cerr << "argument fault" << endl;
    exit(1);
  }

  nice(atoi(argv[1]));

  for (i = 0; i < 100; i++)
    for (j = 0; j < 1000000; j++)
      sum = sum + (double)i;

  return 0;
}
