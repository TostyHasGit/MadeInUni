#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <semaphore.h>

#define NUM_THREADS 400
#define HOWMANY 50

unsigned howMany = HOWMANY;
int apples;
int oranges;
sem_t sem_apples;
sem_t sem_oranges;


void produce(void *arg) {
    int myArg = *((int *) arg);
    myArg++;
}

void consume(void *arg) {
    int myArg = *((int *) arg);
    myArg--;
}

void *thread_produce(void *argument) {
    int howMany = *((int *) argument);

    for (int i = 0; i < howMany; i++) {
      
        sem_wait(&sem_apples);
        sem_wait(&sem_oranges);
        produce(&apples);
        produce(&oranges);
        sem_post(&sem_apples);
        sem_post(&sem_oranges);
    }

    return NULL ;
}

void *thread_consume(void *argument) {
    int howMany = *((int *) argument);

    for (int i = 0; i < howMany; i++) {
        sem_wait(&sem_oranges);
        sem_wait(&sem_apples);
        consume(&oranges);
        consume(&apples);
        sem_post(&sem_apples);
        sem_post(&sem_oranges);
    }

    return NULL ;
}

int main(void) {
    // initialize variables
    pthread_t threads[NUM_THREADS];
    apples = 0;
    oranges = 0;
    if (sem_init(&sem_apples, 0, 1) == -1
            || sem_init(&sem_oranges, 0, 1) == -1) {
        perror("sem_init() failed!");
    }

    // create all threads one by one
    for (int i = 0; i < NUM_THREADS; i++) {
        printf("In main: creating thread %d\n", i);
        if (i % 2 == 0) {
               if (pthread_create(&threads[i], NULL, thread_produce,
                   (void *) &howMany) != 0) {
                perror("pthread_create() failed (thread_produce)");
            }
        } else {
            if (pthread_create(&threads[i], NULL, thread_consume,
                    (void *) &howMany) != 0) {
                perror("pthread_create() failed (thread_consume)");
            }
        }
    }

    // wait for each thread to complete
    for (int i = 0; i < NUM_THREADS; i++) {
        // block until thread i completes
        if (pthread_join(threads[i], NULL) != 0) {
            perror("pthread_join() failed");
        }
        printf("In main: thread %d is complete\n", i);
    }

    printf("apples is %d; oranges is %d; should both be 0\n", apples, oranges);
    exit(EXIT_SUCCESS);
}
