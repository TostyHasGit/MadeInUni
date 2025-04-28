#include "linkedqueue.h"
using namespace std;

int main(int argc, const char *argv[]){
	args_t args(argc, argv);
	Timer timer;
	singlelinked_queue q;
	singlelinked_queue q1;

	string fname = args.pos(0, "atwi80d.txt");
	vector<string> words = read_words(fname);
	size_t size = words.size();
	cout << "insgesamt gibts: " << size << "wörter" << endl;

	int n = 0;
	string s;
	for(size_t i{0}; i < size; ++i){
		s = words[i];

		lqueue_enter(&q, s);
		if(n < s.size()){
			n = s.size();
		}
	}
	cout << "Längste wort hat: " << n << endl;

//	size_t anzahln = 0;
	size_t temp = 0;
	string test;
//	size_t temp1;
	{
		while(!(lqueue_is_empty(&q))){
			for(size_t i = 0; i< size; ++i){
				test = lqueue_leave(&q);
				if(test.size() == n){
					lqueue_enter(&q1, test);
					temp++;
				}
				else
					lqueue_enter(&q, test);

			}
			cout << "Wörter mit " << n << " Buchstaben: " << temp << endl;
			temp = 0;
			n--;
			size = lqueue_size(&q);
		}
	}

	cout << "Lesen dauerte: " << timer.human_measure() << endl;
}
