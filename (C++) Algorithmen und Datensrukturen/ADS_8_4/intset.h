#ifndef INTSET_H_
#define INTSET_H_
#include "pbma.h"

struct intset_node {
	intset_node* left;
	intset_node* right;
	int val;

};
struct intset{
	intset_node* root;
};

	void is_init(intset* is);
	void is_clear(intset_node *n);
	void is_clear(intset* is);
	intset_node*& _is_get_node(intset *is, const int& ele);
	bool is_add(intset* is, int ele);
	bool is_contains(intset* is, int ele);
	void is_remove_node(intset_node *n);
	bool is_remove(intset* is, int ele);
	bool is_isempty(intset* is);
	size_t is_size(intset* is);



#endif /* INTSET_H_ */
