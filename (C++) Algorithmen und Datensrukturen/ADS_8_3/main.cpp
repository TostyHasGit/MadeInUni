#include "pbma.h"
using namespace std;

bool vis_add(vector<int> &vis, int ele) {
	for (size_t i { 0 }; i < vis.size(); ++i) {
		if (vis[i] == ele) {
			return false;
		}
	}
	vis.push_back(ele);
	return true;
}

bool vis_contains(vector<int> &vis, int ele) {
	for (size_t i { 0 }; i < vis.size(); ++i) {
		if (vis[i] == ele) {
			return true;
		}
	}
	return false;
}

bool vis_remove(vector<int> &vis, int ele) {
	for (size_t i { 0 }; i < vis.size(); ++i) {
		if (vis[i] == ele) {
			vis.erase(vis.begin() + i);
			return false;
		}
	}
	return false;
}

int main(int argc, const char *argv[]) {
	args_t args(argc, argv);
	vector<int> a = create_same_randints(10000, 1, 3000);
	vector<int> b;

	if (args.flag("intset")) {

		for (size_t i { 0 }; i < 5000; ++i) {
			vis_add(b, a[i]);
		}
		cout << b.size() << endl;

		for (size_t i { 5000 }; i < 10000; ++i) {
			vis_remove(b, a[i]);
		}

		for (size_t i { 0 }; i < a.size(); ++i) {
			cout << a[i] << " ";
		}
		cout << endl;
		cout << b.size();

	}
}
