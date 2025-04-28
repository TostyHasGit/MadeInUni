#include<iostream>
#include"pbma.h"
#include<vector>
#include<string>

using namespace std;

struct Person
	{
		const char* vorname;
		const char* nachname;
		unsigned int alter;
		int punkte[50];
	};

void mP(vector<Person> mp)
{
	int f{0};
	int max{0};
	int n{0};

	for(int i=0; i<17; i++)
	{
		for(int z=0; z<50; z++)
		{
			f = f + mp[i].punkte[z];
		}

		if(f > max)
		{
			max = f;
			n = i;

		}
		f = 0;
	}

	cout << "Die Person mit den meisten Punkte ist " << mp[n].alter
		 << " Jahre alt und hat " << max << " Punkte." << endl;

}

int main()
{
	vector<Person> feld;


	for(int i=0; i<17; i++)
	{

		Person a;
		vector<int> zahlen;
		zahlen = create_randints(50, 0, 20);

		a.vorname = "Susi";
		a.nachname = "sinnlos";
		a.alter = 18+i;

		for(int j=0; j<50; j++)
		{
			a.punkte[j] = zahlen[j];
		}

		feld.push_back(a);

		cout << i << ". "<< "Person " << feld.at(i).vorname << " "<< feld.at(i).nachname << " " << feld.at(i).alter <<  ": ";

		for(int k=0; k<50; k++)
		{
			cout << feld.at(i).punkte[k]<< " ";
		}

		cout << endl;

	}
	mP(feld);
	return 0;
}
