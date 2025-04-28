#include "hashmapv.h"

void hmv_init(hashmap_verkettung *hmv, std::size_t capacity) {
	hmv->capacity = capacity;
	hmv->size = 0;
	hmv->table = new hmvnode*[capacity] { nullptr };
}

void hmv_clear(hashmap_verkettung *hmv) {
	for (std::size_t i = 0; i < hmv->capacity; ++i) {
		hmvnode *entry = hmv->table[i];
		while (entry != nullptr) {
			hmvnode *pred = entry;
			entry = entry->next;
			delete pred;
		}
	}
	delete[] hmv->table;
}

int* hmv_get(hashmap_verkettung *hmv, const string &key) {
	size_t hash_value = hmv->hash_function(key);
	hash_value = hash_value % hmv->capacity;
	hmvnode *entry = hmv->table[hash_value];
	while (entry != nullptr) {
		if (entry->key == key) {
			return &entry->value;
		}
		entry = entry->next;
	}
	return nullptr;
}

void hmv_put(hashmap_verkettung *hmv, const string &key, int value) {
	size_t hash_value = hmv->hash_function(key);
	hash_value = hash_value % hmv->capacity;
	hmvnode *pred = nullptr;
	hmvnode *entry = hmv->table[hash_value];
	while (entry != nullptr && entry->key != key) {
		pred = entry;
		entry = entry->next;
	}
	if (entry == nullptr) {
		entry = new hmvnode { key, value, nullptr };
		hmv->size += 1;
		if (pred == nullptr) {
			hmv->table[hash_value] = entry;
		} else {
			pred->next = entry;
		}
	} else {
		entry->value = value;
	}
}

bool hmv_remove(hashmap_verkettung *hmv, const string &key) {
	size_t hash_value = hmv->hash_function(key);
	hash_value = hash_value % hmv->capacity;
	hmvnode *pred = nullptr;
	hmvnode *entry = hmv->table[hash_value];
	while (entry != nullptr && entry->key != key) {
		pred = entry;
		entry = entry->next;
	}
	if (entry == nullptr) {
		return false;
	} else {
		if (pred == nullptr) {
			hmv->table[hash_value] = entry->next;
		} else {
			pred->next = entry->next;
		}
		delete entry;
		hmv->size -= 1;
		return true;
	}
}
