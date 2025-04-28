#include "intset.h"
using namespace std;

int main(int argc, const char *argv[]) {
	args_t args(argc, argv);
	Timer timer;
	intset b;
	is_init(&b);

	if (args.flag("intset")) {
		vector<int> a = create_same_randints(10000, 1, 3000);

		for (size_t i { 0 }; i < 5000; ++i) {
			is_add(&b, a[i]);
		}
		cout << is_size(&b) << endl;

		for (size_t i { 5000 }; i < 10000; ++i) {
			is_remove(&b, a[i]);
		}

		cout << is_size(&b) << " " << timer.human_measure() << endl;

	}

	if (args.flag("bench")) {
		vector<int> a = create_same_randints(100000, 1, 100000);

		for (size_t i { 0 }; i < 50000; ++i) {
			is_add(&b, a[i]);
		}
		cout << is_size(&b) << endl;

		for (size_t i { 50000 }; i < 100000; ++i) {
			is_remove(&b, a[i]);
		}

		cout << is_size(&b) << " " << timer.human_measure() << endl;

	}
}
