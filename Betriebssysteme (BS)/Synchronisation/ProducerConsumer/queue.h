#ifndef QUEUE_H
#define QUEUE_H

#include <cstddef>
#include <stdexcept>


class Queue {
public:
    Queue(size_t cap);
    Queue(const Queue& ) = delete;
    Queue& operator=(const Queue& ) = delete;
    virtual ~Queue();
    virtual size_t size() const;
    virtual bool is_full() const;
    virtual bool is_empty() const;
    virtual void put(const int& ele);
    virtual int get();
private:
    int* _array;
    size_t _head;
    size_t _tail;
    size_t _size;
    size_t _cap;
};

#endif // QUEUE_H
