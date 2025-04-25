#include "queue.h"
#include <cstddef>
#include <stdexcept>

using namespace std;

Queue::Queue(size_t cap) {
    _array = new int[cap];
    _head = 0;
    _tail = 0;
    _size = 0;
    _cap = cap;
}

Queue::~Queue() {
    delete [] _array;
}

bool Queue::is_full() const {
    return _size == _cap;
}

bool Queue::is_empty() const {
    return _size == 0;
}

size_t Queue::size() const {
    return _size;
}

void Queue::put(const int& ele) {
    if (_size == _cap) { // is_full
        throw std::runtime_error("QueueOverflow");
    }
    _array[_tail] = ele;
    _tail = (_tail+1) % _cap;
    _size += 1;    
}

int Queue::get() {
    if (_size == 0) {
        throw std::runtime_error("QueueUnderflow");
    }
    size_t retidx = _head;
    _head = (_head + 1) % _cap;
    _size -= 1;
    return _array[retidx];
}

