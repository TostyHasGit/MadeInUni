#include "pbma.h"
using namespace std;

template<typename T>
int find(T *vec, int len, const T &val) {
	int idx { 0 };
	while (idx < len) {
		if (vec[idx] == val) { // == auf T notwendig
			return idx;
		}
		idx += 1;
	}
	return -1;
}

template<typename T>
T max(T *vec, int len) {
	int idx { 0 };
	T maximum { 0 };
	while (idx < len) {
		if(maximum <= vec[idx]){
			maximum = vec[idx];
		}
		idx += 1;
	}
	return maximum;
}

int main() {

	int a[]{0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
	int len = sizeof(a)/sizeof(int);
	cout << find(a, len, 5) << endl;
	cout << max(a, len) << endl;

	const char * acp[]{"hallo", "hi", "servus","salut", "ciao", "aloita"};
	int len_acp{sizeof(acp) / sizeof(acp[0])};
	const char *cp = "salut";
	cout << find(acp, len_acp, cp) << endl;
	cout << max(acp, len_acp) << endl;

}
