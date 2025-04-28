#include <iostream>
#include "pbma.h"
#include "pbmag.h"
#include "dame.h"
using namespace std;

Board* board;

void show(vector<int>& dame, int n){
	cout << "Lösungsvector: " << endl;
	for(int i{0}; i < n; i++){
		cout << dame[i]<< " ";
	}
	cout << endl;
	cout << "Visualisierung: " << endl;
	cout << "    ";
	for(int k{0}; k < n; k++){
		cout << k << " ";
	}
	cout << endl;

	for(int i = n-1; i >= 0; --i){
		if(i < 10){
			cout << "  " << i<< "|";
		}
		if(i > 9){
			cout << " "<< i<< "|";
		}
		if(i > 99){
			cout << i<< "|";
		}
			for(int z = 0; z < dame[i]; ++z){
				if(z < 10){
					cout << "  ";
				}
				if(z > 9){
					cout << "   ";
				}
				if(z > 99){
					cout << "    ";
				}
			}
			cout << "*" << endl;
	}
	cout << endl;
}

bool display(args_t args, int b, vector<int> dame){
	if(args.flag("d")){
		board->setSize(b);
		for(size_t i{0}; i < dame.size(); ++i){
				board->setSquare(i, dame[i],  sf::Color::Green);
				schlafe_ms(500);
				board->render();
				schlafe_ms(30);
//				board->resetSquare(i , dame[i]);
		}
		schlafe_ms(6000);
		return true;
	}
	return false;
}

int main(int argc, const char* argv[]){
	args_t args(argc, argv);
	Timer timer;
	int b = args.int_pos(0, 0);
	vector<int> a(b, -1);

	board = new Board(b);

	if(args.flag("a")){
		solve_ndamen_all(a, 0);
		cout << "Mögliche Lösungen: " << cnt_sols << endl;

	}

	a = solve_ndamen(b);
	cout << "Zeit für Berechnung: " << timer.human_measure() << endl;
	show(a, b);

	display(args, b, a);

	delete board;
}

