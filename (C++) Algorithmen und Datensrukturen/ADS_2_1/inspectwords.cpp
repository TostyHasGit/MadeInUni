#include <iostream>
#include "pbma.h"
#include <vector>
#include <string>
using namespace std;

int words(vector<string> a){
	vector<int> kbuchstaben('z'-'a'+1, 0);
	vector<int> gbuchstaben('Z'-'A'+1, 0);

	for(int i=0; i < a.size(); i++){
		int x = 0;
		char wordb = 'A';

		for(char word ='a'; word < 'z'; word++){

			if(a[i][0] == word){
				kbuchstaben[x] += 1;
				break;
			}

			if(a[i][0] == wordb){
				gbuchstaben[x] += 1;
				break;
			}

			wordb+=1;
			x++;
		}
	}

	for(int j=0; j < 26; j++){
		cout << (char)(j+'a') << ": " << kbuchstaben[j] << " " << (char)(j+'A') << ": " << gbuchstaben[j] << endl;
	}
}
	int main(int argc, const char* argv[]){

		args_t args(argc, argv);
		string fname = args.pos(0, "atwi80d.txt");
		vector<string> a = read_words(fname);
		Timer timer;

		int w = a.size();
		int b{0};
		int bigword{0};
		int smalword = a[0].size();

		for(int i=0; i < w; i++){
			b = b + a[i].size();

			if(bigword < a[i].size()){
				bigword = a[i].size();
			}

			if(smalword > a[i].size()){
				smalword = a[i].size();
			}
		}
		cout << "Es sind insgesammt: " << w << " Wörter." << endl;
		cout << "Es sind insgesammt: " << b << " Buchstaben." << endl;
		cout << "Das längste Wort hat: " << bigword << " Buchstaben" << endl;
		cout << "Das kürzeste wort hat: " << smalword <<" Buchstaben" << endl;
		cout << "Anzahl der jeweiligen Buchstaben: " << endl;
		words(a);

		cout << "Lesen dauerte: " << timer.human_measure() << endl;
}
