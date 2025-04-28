/*
 * main.cpp
 *
 *  Created on: 17.03.2023
 *      Author: n3004549
 */

#include <limits>
#include <iomanip>
#include <iostream>
using namespace std;

int main()
{
	cout << setw(20) << "int" << " " << sizeof(int) << ": ";
	cout << setw(20) << numeric_limits<int>::min() << " .. ";
	cout << setw(20) << numeric_limits<int>::max() << endl;

	cout << setw(20) << "long" << " " << sizeof(long) << ": ";
	cout << setw(20) << numeric_limits<long>::min() << " .. ";
	cout << setw(20) << numeric_limits<long>::max() << endl;

	cout << setw(20) << "double" << " " << sizeof(double) << ": ";
	cout << setw(20) << numeric_limits<double>::min() << " .. ";
	cout << setw(20) << numeric_limits<double>::max() << endl;

	cout << setw(20) << "float" << " " << sizeof(float) << ": ";
	cout << setw(20) << numeric_limits<float>::min() << " .. ";
	cout << setw(20) << numeric_limits<float>::max() << endl;

	cout << setw(20) << "char" << " " << sizeof(char) << ": ";
	cout << setw(20) << (int) numeric_limits<char>::min() << " .. ";
	cout << setw(20) << (int) numeric_limits<char>::max() << endl;

	cout << setw(20) << "short" << " " << sizeof(short) << ": ";
	cout << setw(20) << numeric_limits<short>::min() << " .. ";
	cout << setw(20) << numeric_limits<short>::max() << endl;


	cout << setw(20) << "unsigned int" << " " << sizeof(unsigned int) << ": ";
	cout << setw(20) << numeric_limits<unsigned int>::min() << " .. ";
	cout << setw(20) << numeric_limits<unsigned int>::max() << endl;

	cout << setw(20) << "unsigned long" << " " << sizeof(unsigned long) << ": ";
	cout << setw(20) << numeric_limits<unsigned long>::min() << " .. ";
	cout << setw(20) << numeric_limits<unsigned long>::max() << endl;

	cout << setw(20) << "unsigned short" << " " << sizeof(unsigned short) << ": ";
	cout << setw(20) << numeric_limits<unsigned short>::min() << " .. ";
	cout << setw(20) << numeric_limits<unsigned short>::max() << endl;

}
