#pragma once
#include "wymierna.hpp"
using namespace obliczenia;
using namespace std;

int main() {
	cout << "wymierna1 = wymierna(2359348, 99900)" << endl;
	wymierna wymierna1 = wymierna(2359348, 99900);
	cout << wymierna1 << endl;

	cout << "wymierna2 = wymierna(4)" << endl;
	wymierna wymierna2 = wymierna(4);
	cout << wymierna2 << endl;

	cout << "wymierna1 + wymierna2" << endl;
	wymierna wymierna3 = wymierna1 + wymierna2;
	cout << wymierna3 << endl;

	cout << "-wymierna2" << endl;
	cout << -wymierna2 << endl;

	cout << "!wymierna2" << endl;
	cout << !wymierna2 << endl;

	cout << "double(wymierna1)" << endl;
	cout << double(wymierna1) << endl;

	cout << "int(wymierna1)" << endl;
	cout << int(wymierna1) << endl;

	//wymierna wymierna4 = wymierna(1, 0);

	return 1;
}