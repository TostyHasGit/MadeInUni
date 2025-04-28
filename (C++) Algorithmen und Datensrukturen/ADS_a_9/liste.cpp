#include "liste.h"
using namespace std;

void liste_init(liste *lis) {
	lis->head = nullptr;
	lis->len = 0;
}
void liste_init(liste *lis, const liste *other) {
	liste_init(lis);
	liste_node *h = other->head;
	for (size_t i { 0 }; i < other->len; ++i) {
		liste_pushback(lis, h->ele);
		h = h->next;
	}
}
void liste_assign(liste *dst, const liste *src) {
	liste_clear(dst);
	liste_init(dst);
	liste_node *h = src->head;
	for (size_t i { 0 }; i < src->len; ++i) {
		liste_pushback(dst, h->ele);
		h = h->next;
	}

}
void liste_clear(liste *lis) {
	while (lis->head != nullptr) {
		liste_node *to_del = lis->head;
		lis->head = lis->head->next;
		delete to_del;
	}
	lis->len = 0;
}
void liste_pushfront(liste *lis, T t) {

	liste_node *n = new liste_node;
	n->ele = t;
	n->next = lis->head;
	lis->head = n;
	lis->len += 1;

}
void liste_pushback(liste *lis, T t) {
	liste_node *n = new liste_node;
	n->next = nullptr;
	n->ele = t;
	if (lis->head == nullptr) {
		lis->head = n;
		lis->len += 1;
		return;
	}
	liste_node *h = lis->head;
	while (h->next != nullptr) { // Suche letztes
		h = h->next;
	}
	h->next = n;
	lis->len += 1;
}
void liste_append(liste *lis, const liste *other) {
	liste_node *h = other->head;
	for (size_t i { 0 }; i < other->len; ++i) {
		liste_pushback(lis, h->ele);
		h = h->next;
	}

}
liste liste_plus(const liste *src1, const liste *src2) {
	liste lis;
	liste_init(&lis);

	liste_node *n1 = src1->head;
	liste_node *n2 = src2->head;

	for (size_t i { 0 }; i < src2->len; ++i) {
		liste_pushback(&lis, n1->ele + n2->ele);
		n1 = n1->next;
		n2 = n2->next;
	}

	return lis;

}

size_t liste_size(const liste *lis) {
	liste_node *h = lis->head;
	size_t size = 0;
	while (h != nullptr) {
		h = h->next;
		size += 1;
	}
	return size;
}
bool lis_is_empty(liste *lis) {
	return lis->head == nullptr;

}
