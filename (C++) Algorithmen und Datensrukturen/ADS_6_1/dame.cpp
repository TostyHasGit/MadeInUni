#include "dame.h"
#include "pbmag.h";
using namespace std;


int try_cnt;
int cnt_sols = 0;

bool assign_ok(const vector<int>& a, int row, int col) {
	for (int j = 0; j < row; j += 1) {
		if (a[j] == col) {
			return false;
		}
		if (a[j] == col - (row - j)) {
			return false;
		}
		if (a[j] == col + (row - j)) {
			return false;
		}
	}
	return true;
}

bool solve_ndamen(vector<int>& a, int row) {
	int n = a.size();
		if (n == row) {
			return true;
		}
		for (int col = 0; col < n; col += 1) {
			if (assign_ok(a, row, col)) {
				a[row] = col;
				try_cnt += 1;
				if (solve_ndamen(a, row + 1)) {
					return true;
				}
				a[row] = -1;
			}
		}
		return false;
}

vector<int> solve_ndamen(int n) {
	vector<int> res(n);
	bool ok = solve_ndamen(res, 0);
	if (!ok) {
		res[0] = -1;
	}
	return res;
}


void solve_ndamen_all(vector<int>& a, int row) {
	int n = a.size();
	if (n == row) {
		cnt_sols += 1;
		return;
	}
	for (int col = 0; col < n; col += 1) {
		if (assign_ok(a, row, col)) {
			a[row] = col;
			try_cnt += 1;
			solve_ndamen_all(a, row + 1);
				a[row] = -1;
		}
	}
}

