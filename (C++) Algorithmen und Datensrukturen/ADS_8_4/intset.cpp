#include "intset.h"

void is_init(intset *is) {
	is->root = nullptr;
}

void is_clear(intset_node *n) {
	if (n == nullptr) {
		return;
	}
	is_clear(n->left);
	is_clear(n->right);
	delete n;
}

void is_clear(intset *is) {
	is_clear(is->root);
	is->root = nullptr;
}
intset_node*& _is_get_node(intset *is, const int& ele) {
	intset_node *n = is->root;
	intset_node **last = &is->root;
	while (n != nullptr) {
		if (ele == n->val) {
			return *last;
		} else if (ele < n->val) {
			last = &n->left;
			n = n->left;
		} else {
			last = &n->right;
			n = n->right;
		}
	}
	return *last;
}

bool is_add(intset *is, int ele) {

	intset_node *&n = _is_get_node(is, ele);
	if (n != nullptr) {
		n->val = ele;
		return false;
	}
	n = new intset_node { nullptr, nullptr, ele };
	return true;
}

bool is_contains(intset *is, int ele) {
	intset_node *n = is->root;
	intset_node *last = is->root;
	while (n != nullptr) {
		if (ele == n->val) {
			return true;
		} else if (ele < n->val) {
			last = n->left;
			n = n->left;
		} else {
			last = n->right;
			n = n->right;
		}
	}
	return false;
}
void is_remove_node(intset_node *n) {
	if (n->left == nullptr || n->right == nullptr) {
		intset_node *todel = (n->left == nullptr) ? n->right : n->left;
		*n = *todel;
		delete todel;
		return;
	}
}
bool is_remove(intset *is, int ele) {
	intset_node *&n = _is_get_node(is, ele);
	if(n == nullptr){
		return false;
	}
	if (n->left == nullptr && n->right == nullptr) {
		delete n;
		n = nullptr;
	} else {
		is_remove_node(n);
	}
	return true;
}

bool is_isempty(intset *is) {
	if (is->root == nullptr) {
		return true;
	}
	return false;
}

size_t _is_size(intset_node *n) {
	if (n == nullptr) {
		return 0;
	}
	return _is_size(n->left) + _is_size(n->right) + 1;
}

size_t is_size(intset *is) {
	return _is_size(is->root);
}

