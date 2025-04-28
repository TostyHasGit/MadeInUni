#include "Participant.h"
#include "pbma.h"
#include "Time.h"
using namespace std;

int main(int argc, const char* argv[]){
	args_t args(argc, argv);
	vector<Participant> teilnehmer;
	vector<string> namen = args.positionals();
	vector<int>zeiten = create_randints(namen.size(), 0 , 1000);

	for(size_t i=0; i < namen.size(); i++){
		Participant a(namen[i], zeiten[i]);
		teilnehmer.push_back(a);
		cout << teilnehmer[i].get_name() << " : ";
		teilnehmer[i].get_time();
	}
	int winner = teilnehmer[0].get_time2().justseconds();
	int k = 0;
	for(size_t i=1; i <namen.size(); i++){
		if(winner > teilnehmer[i].get_time2().justseconds()){
			winner = teilnehmer[i].get_time2().justseconds();
			k+=1;
		}
	}
	cout << "Gewinner ist " << teilnehmer[k].get_name() << "mit : ";
	teilnehmer[k].get_time();


}
