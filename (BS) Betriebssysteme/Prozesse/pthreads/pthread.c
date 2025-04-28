#include <pthread.h>
#include <stdio.h>

void *add(void *arg);

typedef struct {
  int a, b, erg;
} Buffer;


int main()
{   
  pthread_t tid;
  int *erg;
  Buffer buf;

  printf("(Thread Nr. %u) ", (unsigned)pthread_self());
  printf("Enter two integer arguments: ");
  scanf("%d %d", &buf.a, &buf.b);

  pthread_create( &tid, NULL, add, &buf);
  pthread_join(tid, (void *)&erg );

  printf("(Thread Nr. %u) Result: %d\n", (unsigned)pthread_self(), *erg );
  return 0;
}

void *add(void *arg)
{
  Buffer *buf = (Buffer*)arg;
  printf("(Thread Nr. %u) Computing sum\n", (unsigned)pthread_self());
  buf->erg = buf->a + buf->b;
  pthread_exit(&(buf->erg));
}
