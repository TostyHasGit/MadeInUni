#include <thread>
#include <iostream>

using namespace std;

static const int NUM_THREADS = 50;
static const int LOOPSIZE = 10000;


struct Lock {
    bool choosing[NUM_THREADS];
    int number[NUM_THREADS];
    Lock() {
        for(int i = 0; i < NUM_THREADS; ++i) {
            choosing[i] == false;
            number[i] == 0;
       }
    }
} lock;

int sum = 0;

void wait(Lock *L, int my_id) {
    // Ziehen einer Nummer größer als alle vorherigen
    L->choosing[my_id] = true;
    int max_number = 0;
    for(int i = 0; i < NUM_THREADS; ++i) {
        if (L->number[i] > max_number) 
            max_number = L->number[i];
    }
    L->number[my_id] = max_number + 1;
    L->choosing[my_id] = false;
    // Warten bis eigene Nummer an der Reihe
    for(int i = 0; i < NUM_THREADS; ++i) {
        while(L->choosing[i]) std::this_thread::yield();
        while(L->number[i] > 0 &&
              (L->number[i] < L->number[my_id] ||
               // id zur Entscheidung bei gleicher Nummer
               (L->number[i] == L->number[my_id] &&
               i < my_id))) std::this_thread::yield();
    }
}

void release(Lock *L, int my_id) {
  L->number[my_id] = 0;
}

void thread_sum(int loopSize, int my_id) {
    for (int i = 0; i < loopSize; i++) {
        wait(&lock, my_id);
        sum ++;
        release(&lock, my_id);
    }
    return;
}

int main() {
    // initialize variables
    thread threads[NUM_THREADS];
    int thread_args[NUM_THREADS];
        
    // create all threads one by one
    for (int i = 0; i < NUM_THREADS; i++) {
        thread_args[i] = LOOPSIZE;
        cout << "In main: creating thread " << i << endl;
        threads[i] = thread(thread_sum, thread_args[i], i);
    }

    // wait for each thread to complete
    for (int i = 0; i < NUM_THREADS; i++) {
        // block until thread i completes
        threads[i].join();
        cout << "In main: thread " << i << " is complete" << endl;
    }

    cout << "Sum is " << sum << ", should be " << NUM_THREADS * LOOPSIZE << endl;
}


