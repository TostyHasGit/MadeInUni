/*
 * ggT.cpp
 *
 *  Created on: 17.03.2023
 *      Author: n3004549
 */

#include <iostream>
using namespace std;

int ggt1(int x, int y)
{
	while(x != y)
	{
		if(x<y)
		{
			int z = x;
			x = y;
			y = z;
		}

		x = x-y;
	}
	return x;
}

int ggt2(int x, int y)
{
	int z;
	while(z != 0)
	{
		x = x%y;
		z = x;
		x = y;
		y = z;
	}
	return x;
}

int main()
{
	int a;
	int b;

	cout << "Geben Sie zwei Zahlen ein:" << endl;
	cin >> a;
	cin >> b;
	ggt1(a, b);
	ggt2(a, b);
	cout << ggt1(a, b) << endl;
	cout << ggt2(a, b) << endl;

}

