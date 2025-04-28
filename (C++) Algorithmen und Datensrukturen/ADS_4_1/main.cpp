#include <iostream>
#include "pbma.h"
using namespace std;

void selection_sort(vector<int>& a) {
	size_t asize = a.size();
	for (size_t i = 0; i < asize - 1; i += 1) {
		size_t min = i;
		for (size_t j = i + 1; j < asize; j += 1) {
			if (a[min] > a[j]) {
				min = j;
			}
		}
		if (min != i) {
			swap(a, min, i);
		}
	}
}

void insertion_sort(vector<int>& a){
size_t asize = a.size();
for (size_t i = 1; i < asize; i += 1) {
	size_t j = i;
	while ((j > 0) && (a[j - 1] > a[j])) {
		swap(a, j - 1, j);
		j -= 1;
	}
 }
}

int main(){
	vector<int> a = create_randints(10, 0, 100);
	selection_sort(a);
	insertion_sort(a);

	check_sort(insertion_sort, true);
	int first_error;
	if(!is_sorted(a, first_error)){
		cout << "NOT SORTED: " << first_error << endl;
	}
}
