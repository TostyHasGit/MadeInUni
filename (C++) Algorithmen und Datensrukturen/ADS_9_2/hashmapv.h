#ifndef HASHMAPV_H_
#define HASHMAPV_H_
#include "pbma.h"


struct hmvnode{
	std::string key;
	int value;
	hmvnode* next;
};

struct hashmap_verkettung {
	size_t capacity;
	size_t size;
	hmvnode* table;
};


void hmv_init(hashmap_verkettung* hmv, std::size_t capacity=6151);
void hmv_clear(hashmap_verkettung* hmv);
int* hmv_get(hashmap_verkettung* hmv, const std::string& key);
void hmv_put(hashmap_verkettung* hmv, const std::string& key, int value);
bool hmv_remove(hashmap_verkettung* hmv, const std::string& key);

#endif /* HASHMAPV_H_ */
