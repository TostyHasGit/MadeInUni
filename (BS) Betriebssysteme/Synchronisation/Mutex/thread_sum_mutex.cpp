#include <thread>
#include <iostream>
#include <mutex>

using namespace std;

static const int NUM_THREADS = 50;
static const int LOOPSIZE = 10000;

int sum = 0;
mutex mtx;

void thread_sum(int loopSize) {
    for (int i = 0; i < loopSize; i++) {
        mtx.lock();
        sum ++;
        mtx.unlock();
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
        threads[i] = thread(thread_sum, thread_args[i]);
    }

    // wait for each thread to complete
    for (int i = 0; i < NUM_THREADS; i++) {
        // block until thread i completes
        threads[i].join();
        cout << "In main: thread " << i << " is complete" << endl;
    }

    cout << "Sum is " << sum << ", should be " << NUM_THREADS * LOOPSIZE << endl;
}




