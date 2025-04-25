#include "sleep.h"
#include <stdlib.h>
#include <unistd.h>

void init_sleep(void) {
  /* init random generator */
  srandom(getpid());
}

void rand_sleep(int us) {
  /* sleep with 50% */
  if (random() % 2)
    usleep(us);
}
