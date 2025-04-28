#include "kleinste.h"
using namespace std;

int kleinste(const vector<int>& a)
{
	int s = a[0];
	for(int i=0; i < a.size(); i++)
	{
		if(s > a[i])
		{
			s = a[i];
		}
	}

}
