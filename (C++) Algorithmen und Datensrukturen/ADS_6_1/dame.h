#ifndef DAME_H_
#define DAME_H_
#include "pbma.h"

extern int try_cnt;
extern int cnt_sols;

//void show(std::vector<int>& dame, int n);

bool assign_ok(const std::vector<int>& a, int row, int col);

bool solve_ndamen(std::vector<int>& a, int row);

std::vector<int> solve_ndamen(int n);

void solve_ndamen_all(std::vector<int>& a, int row);


#endif /* DAME_H_ */
