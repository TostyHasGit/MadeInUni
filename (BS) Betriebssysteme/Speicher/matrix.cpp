#include <iostream>
#include <sys/time.h>

//#define DIM  4096 // 64 MB
#define DIM  16384  // 1 GB

int vek[DIM][DIM];

using namespace std;

int main(int argc, char *argv[])
{
  time_t begin, end, elapsed ;
  int i, j;
 
  time(&begin);
  for (i=0; i<DIM; i++)
       for (j=0; j<DIM; j++)
          vek[i][j] = 1;
  time(&end);
  elapsed = end - begin;
  cout << "linewise access: " << elapsed << " sec" << endl;
  
  time(&begin);
  for (i=0; i<DIM; i++)
       for (j=0; j<DIM; j++)
          vek[j][i] = 1;
  time(&end);
  elapsed = end - begin;
  cout << "columnwise access: " << elapsed << " sec\n";

  return 0;
}  


  
 
  
