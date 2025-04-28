#include "liste.h"
using namespace std;

void liste_show(const char *msg, const liste *lis) {
	cout << msg << ": ";
	cout << "len=" << liste_size(lis) << "[ ";
	for (liste_node *n = lis->head; n != nullptr; n = n->next) {
		cout << n->ele << " ";
	}
	cout << "]" << endl;
}
int main(int argc, const char *argv[]) {
	liste lis;
	liste_init(&lis);
	liste_pushback(&lis, 17);
	liste_show("1", &lis); // [ 17 ]
	liste_pushback(&lis, 42);
	liste_pushback(&lis, 666);
	liste_pushfront(&lis, 6);
	liste_show("2", &lis); // [ 6 17 42 666 ]
	for (liste_node *n = lis.head; n != nullptr; n = n->next) {
		n->ele += 1;
	}
	liste_show("3", &lis); // [ 7 18 43 667 ]
	liste lisb;
	liste_init(&lisb, &lis);
	liste lisc;
	liste_init(&lisc, &lisb);
	liste_assign(&lisc, &lis);
	liste_show("4", &lisc); // [ 7 18 43 667 ]
	liste_append(&lis, &lisb);
	liste_show("5", &lis); // [ 7 18 43 667 7 18 43 667 ]
	liste_clear(&lis);

	lis = liste_plus(&lisc, &lisc);
	liste_show("6", &lis);
	liste_clear(&lisc);
	liste_clear(&lisb);
	liste_clear(&lis);
}

