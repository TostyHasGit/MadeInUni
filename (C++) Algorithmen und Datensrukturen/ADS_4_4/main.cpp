#include <iostream>
#include "pbma.h"
using namespace std;

void sort(vector<int>& a){
	int m{0};

	for(int i{0}; i < a.size(); i++){
			if(m < a[i]){
				m = a[i];
			}
	}

	vector<int> counter(m+1);
	vector<int> c(a.size());

	for(int i{0}; i < a.size(); i++){
		counter[a[i]]++;
	}


	for(int i{0}; i < m+1; i++){
		counter[i] += counter[i-1];
		cout << counter[i] << " ";
	}
	 cout << endl;

	for(int i{0}; i < a.size(); i++){
		c[counter[a[i]]-1] = a[i];
		counter[a[i]]--;
	}

	for(int i{0}; i < a.size(); i++){
		a[i] = c[i];
		cout << a[i] << " ";
	}
}

int main(){
	vector<int> a {1, 3 ,2 , 6 ,3 , 2, 6 ,5 ,1 , 2, 1};
	sort(a);

//	check_sort(sort, true);
//	int first_error;
//	if(!is_sorted(a, first_error)){
//		cout << "NOT SORTED: " << first_error << endl;
//	}

}
