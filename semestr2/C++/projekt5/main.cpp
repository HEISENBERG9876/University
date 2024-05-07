#include "piksele.hpp"
#include "kolory.hpp"

using namespace std;


int main() {
	//KOLORY
	kolor kolor1 = kolor();
	cout << "kolor kolor1 = kolor();" << endl;
	cout << kolor1;
	

	kolor kolor2 = kolor(255, 255, 255);
	cout << "kolor kolor2 = kolor(255, 255, 255);" << endl;
	cout << kolor2;

	kolor kolor3 = kolor::polacz(kolor1, kolor2);
	cout << "kolor kolor3 = kolor::polacz(kolor1, kolor2);" << endl;
	cout << kolor3;

	kolor3.przyciemnij(50);
	cout << "kolor3.przyciemnij(50);" << endl;
	cout << kolor3;

	kolortransparentny transparent1 = kolortransparentny();
	cout << "kolortransparentny transparent1 = kolortransparentny();" << endl;
	cout << transparent1;

	kolortransparentny transparent2 = kolortransparentny(1, 100, 12, 234);
	cout << "kolortransparentny transparent2 = kolortransparentny(1, 100, 12, 234);" << endl;
	cout << transparent2;

	kolornazwany nazwany1 = kolornazwany();
	cout << "kolornazwany nazwany1 = kolornazwany();" << endl;
	cout << nazwany1;

	kolornazwany nazwany2 = kolornazwany(112, 222, 111, "nazwa fajna");
	cout << "kolornazwany nazwany2 = kolornazwany(112, 222, 111, nazwafajna);" << endl;
	cout << nazwany2;

	kolornt nt1 = kolornt();
	cout << "kolornt nt1 = kolornt();" << endl;
	cout << nt1;

	kolornt nt2 = kolornt(1, 100, 12, 234, "super nazwa");
	cout << "kolornt nt2 = kolornt(1, 100, 12, 234, supernazwa);" << endl;
	cout << nt2;


	//PIKSELE
	piksel piksel1 = piksel(1900, 123);
	piksel piksel2 = piksel(1, 4);

	cout << "cout << odleglosc(piksel1, piksel2) << endl;" << endl;
	cout << odleglosc(piksel1, piksel2) << endl;

	pikselkolorowy kolorowy1 = pikselkolorowy(11, 12, transparent1);
	pikselkolorowy kolorowy2 = pikselkolorowy(100, 200, transparent2);

	cout << "cout << odleglosc(kolorowy1, kolorowy2) << endl;" << endl;
	cout << odleglosc(kolorowy1, kolorowy2) << endl;

	piksel* p1 = &kolorowy1;
	piksel* p2 = &kolorowy2;

	cout << "piksel* p1 = &kolorowy1; piksel* p2 = &kolorowy2; cout << odleglosc(*p1, *p2) << endl;" << endl;
	cout << odleglosc(*p1, *p2) << endl;

	cout << "piksel1.dlugosc_do_prawego_dolu()" << endl;
	cout << piksel1.dlugosc_do_prawego_dolu() << endl;

	cout << "piksel1.dlugosc_do_lewego_dolu()" << endl;
	cout << piksel1.dlugosc_do_lewego_dolu() << endl;

	cout << "piksel1.dlugosc_do_prawej_gory()" << endl;
	cout << piksel1.dlugosc_do_prawej_gory() << endl;

	cout << "piksel1.dlugosc_do_lewej_gory()" << endl;
	cout << piksel1.dlugosc_do_lewej_gory() << endl;

	cout << "cout << piksel1 << endl;" << endl;
	cout << piksel1 << endl;

	cout << "cout << kolorowy1 << endl;" << endl;
	cout << kolorowy1 << endl;


	//random testy
	cout << "randomowe testy" << endl;
	cout << piksel2.getX() << kolor2.getBlue() << nazwany2.getBlue() << nazwany2.getNazwa() <<
	 nt2.getAlfa() << nt2.getNazwa() << nt2.getBlue() << " " << piksel1.dlugosc_do_prawego_dolu() << " " << piksel1.getX() <<  endl;
	return 1;
}