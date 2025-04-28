#include <iostream>
#include "merge.h"
#include "pbma.h"
using namespace std;

inline void mycopy(vector<int>& dest, vector<int>& src, size_t from, size_t to){
	for(size_t i{from}; i < to ; i+=1){
		dest[i] = src[i];
	}
}

void mergen(vector<int>& a ,vector<int>& b ,
		size_t li ,size_t eli ,size_t re, size_t ere){

	size_t start = li, end = ere;
	size_t i = li;
	while(li <= eli && re <= ere){
		if(a[li] <= a[re]){
			swap(b, i++, a, li++);
		}
		else{
			swap(b, i++, a, re++);
		}
	}
	while(li <= eli){
		swap(b, i++, a, li++);
	}
	while(re <= ere){
		swap(b, i++, a, re++);
	}
	mycopy(a, b, start, ere +1 );
}

void merge_sort(vector<int>& a ,vector<int>& b ,size_t li ,size_t re){
	if(li==re){
		return;
	}
	size_t mi = (li+re)/2;
	merge_sort(a, b, li, mi);
	merge_sort(a, b, mi + 1, re);
	mergen(a , b , li , mi , mi + 1, re);
}

void merge_sort(vector<int>& a){
	vector<int> b(a.size());
	merge_sort(a, b, 0, a.size()-1);
}

int main(){
	vector<int> a = create_randints(10, 0, 100);
	merge_sort(a);

	check_sort(merge_sort, true);
		int first_error;
		if(!is_sorted(a, first_error)){
			cout << "NOT SORTED: " << first_error << endl;
		}
}

