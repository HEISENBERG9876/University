#include <iostream>
#include "classes.hpp"

using namespace std;


int main() {
	zmienna::dodajZmienna("x", 0);
	zmienna::dodajZmienna("y", 0);

	wyrazenie* w5 = new odejmowanie(
		new pi(),
		new dodawanie(
			new liczba(2),
			new mnozenie(
				new zmienna("x"),
				new liczba(7)
			)
		)
	);

	wyrazenie* w1 = new dzielenie(
		new mnozenie(
			new odejmowanie(new zmienna("x"), new liczba(1)), new zmienna("x")),  new liczba(2)
	);

	wyrazenie* w2 = new dzielenie(
		new dodawanie(
			new liczba(3), 
			new liczba(5)),
		new dodawanie(
			new liczba(2), 
			new mnozenie(
				new zmienna("x"), 
				new liczba(7)))
	);

	wyrazenie* w3 = new dodawanie(
		new liczba(2), 
		new odejmowanie(
			new mnozenie(
				new zmienna("x"), 
				new liczba(7)),
			new dodawanie(
				new mnozenie(
					new zmienna("y"), 
					new liczba(3)), 
				new liczba(5))

	));

	wyrazenie* w4 = 
	new dzielenie(
		new cosinus(
			new mnozenie(
				new dodawanie(
					new zmienna("x"),
					new liczba(1)
				),
				new pi()
			)

		),
		new potegowanie(
			new e(),
			new potegowanie(
				new zmienna("x"),
				new liczba(2)
			)
		)
	);


	double x_values[] = {0, 0, 0.5, 0.5, 1};
	double y_values[] = {0, 0.5, 0, 0.5, 1};

	for (int i = 0; i < 5; i++) {
			double x = x_values[i];
			double y = y_values[i];
			
			cout << "\n x = " << x << " ";
			cout << "\n y = " << y << "\n";
			
			zmienna::modyfikujZmienna("x", x);
			zmienna::modyfikujZmienna("y", y);
			
			cout << w1->zapis() << " = " << w1->oblicz() << endl;
			cout << w2->zapis() << " = " << w2->oblicz() << endl;
			cout << w3->zapis() << " = " << w3->oblicz() << endl;
			cout << w4->zapis() << " = " << w4->oblicz() << endl;
			cout << w5->zapis() << " = " << w5->oblicz() << endl;
	}


	return 1;
}