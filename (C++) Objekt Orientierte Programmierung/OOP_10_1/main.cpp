#include "pbma.h"
#include <algorithm>
using namespace std;

namespace my {
template<typename Iter, typename T>
int my_count(Iter first, Iter end, T val) {
	auto it = first;
	int zaehler { 0 };

	while (it != end) {
		if (*it == val) {
			++zaehler;
		}
		++it;
	}
	return zaehler;
}
template<typename Iter, typename Pred>
int my_count_if(Iter first, Iter end, Pred h) {
	auto it = first;
	int zaehler { 0 };
	while (it != end) {
		if (h(*it)) {
			++zaehler;
		}
		++it;
	}
	return zaehler;
}
}

using namespace my;

int main(int argc, const char *argv[]) {
	args_t args(argc, argv);
	string file = args.pos(0, "atwi80d.txt");
	int zahlen = args.int_option("n", 10000);

	vector<string> words = read_words(file);
	vector<int> a = create_same_randints(10000, 0, zahlen);

	int b = my_count(a.begin(), a.end(), 17);
	cout << "b: " << b << endl;

	int c = my_count_if(a.begin(), a.end(), [](int c) {
		return c > 987;
	});
	cout << "c: " << c << endl;

	int d = my_count_if(a.begin(), a.end(), [](int d) {
		return d % 17 == 0;
	});
	cout << "d: " << d << endl;

	int e = my_count_if(a.begin(), a.end(), [](int e) {
		return e % 17 == 0 || e % 42 == 0;
	});
	cout << "e: " << e << endl << endl;

	int f = my_count(words.begin(), words.end(), "the");
	cout << "f: " << f << endl;

	int g = my_count_if(words.begin(), words.end(), [](string g) {
		return 'A' <= g[0] && g[0] <= 'Z';
	});
	cout << "g: " << g << endl;

	int h = my_count_if(words.begin(), words.end(), [](string h) {
		return h.size() == 3;
	});
	cout << "h: " << h << endl;

	auto ist_kleiner_vokal = [](char ch) {
		return ch == 'a' || ch == 'e' || ch == 'i' || ch == 'o' || ch == 'u';
	};

	auto minddreikleinevokale = [&](const string &s) {
		return my_count_if(begin(s), end(s), ist_kleiner_vokal) >=3;
	};

	int i = my_count_if(words.begin(), words.end(), minddreikleinevokale);
	cout << "i: " << i << endl;

	auto kleinevokale = [&](const string &s) {
		return my_count_if(begin(s), end(s), ist_kleiner_vokal);
	};

	auto ist_kleiner_konsonant = [](char ch) {
		return ch != 'a' && ch != 'e' && ch != 'o' && ch != 'i' && ch != 'u';
	};

	auto kleinekonsonant = [&](const string &s) {
		return my_count_if(begin(s), end(s), ist_kleiner_konsonant);
	};

	int j = my_count_if(words.begin(), words.end(), kleinekonsonant < kleinevokale);
	cout << "j: " << j << endl;

}
