#ifndef LISTE_H_
#define LISTE_H_
#include "pbma.h"

typedef int T;
struct liste_node {
	T ele;
	liste_node *next;
};
struct liste {
	liste_node *head;
	size_t len;
};
void liste_init(liste *lis);
void liste_init(liste *lis, const liste *other);
void liste_assign(liste *dst, const liste *src);
void liste_clear(liste *lis);
void liste_pushfront(liste *lis, T t);
void liste_pushback(liste *lis, T t);
void liste_append(liste *lis, const liste *other);
liste liste_plus(const liste *src1, const liste *src2);
size_t liste_size(const liste *lis);

#endif /* LISTE_H_ */
