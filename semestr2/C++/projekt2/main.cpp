#include "classes.hpp"
using namespace std;;


int main(){
    Wektor wektor = Wektor(4, 3);
    Punkt punkt1 = Punkt(1, 4);
    punkt1.wypiszWsp();
    punkt1.wspX();
    punkt1.wspY();

    cout << "Obracanie punktu 3, 5 wzgledem srodka 3, 5 o kat 40" << endl;
    Punkt punkt2 = Punkt(3, 5);
    Punkt srodek1 = Punkt(3, 5);
    Punkt srodek2 = Punkt(11, 7);
    Punkt punktObrot1 = punkt2.obrot(srodek1, 40);
    Punkt punktObrot2 = punkt2.obrot(srodek2, 40);
    punktObrot1.wypiszWsp();
    cout << "Obracanie punktu 3, 5 wzgledem srodka 11, 7 o kat 40" << endl;
    punktObrot2.wypiszWsp();


    Punkt punkt4 = Punkt(1, 4);
    Punkt punktPrzesun = Punkt(punkt4.przesun(wektor));
    cout << "Przesuniecie punktu 1,4 o wektor (4, 3)" << endl;
    punktPrzesun.wypiszWsp();


    Punkt srodek = Punkt(17, 4);
    Punkt punkt5 = Punkt(3, 5);
    Punkt punktSymSrodek = punkt5.sym_punkt(srodek);
    cout << "Symetria punktowa punktu 3, 5 wzgledem srodka 17, 4" << endl;
    punktSymSrodek.wypiszWsp();

    cout << "Czy 12, 5 jest na odcinku (10, 5) , (15, 5)?" << endl;
    Punkt punkt6 = Punkt(10, 5);
    Punkt punkt7 = Punkt(15, 5);
    Odcinek odcinek1 = Odcinek(punkt6, punkt7);
    Punkt punktNaOdc = Punkt(12, 5);
    Punkt punktNieNaOdc = Punkt(12, 7);
    cout << odcinek1.czy_na_odcinku(punktNaOdc) << endl;
    cout << "Czy 12, 6 jest na odcinku (10, 5) , (15, 5)?" << endl;
    cout << odcinek1.czy_na_odcinku(punktNieNaOdc) << endl;
    

    cout << "Sprawdza czy dwa odcinki (10, 5)(15, 5) (2, 2)(8, 2) sa rownolegle" << endl;
    Punkt punkt8 = Punkt(10, 5);
    Punkt punkt9 = Punkt(15, 5);
    Odcinek odcinek3 = Odcinek(punkt8, punkt9);
    Punkt punkt10 = Punkt(2, 2);
    Punkt punkt11 = Punkt(8, 2);
    Odcinek odcinek4 = Odcinek(punkt10, punkt11);
    cout << czy_rownolegle(odcinek3, odcinek4) << endl;
    

    cout << "Sprawdza czy dwa odcinki (-1, 1)(1, -1)  (-1, -1)(8, 8)sa prostopadle" << endl;
    Punkt punkt12 = Punkt(-1, 1);
    Punkt punkt13 = Punkt(1, -1);
    Odcinek odcinek5 = Odcinek(punkt12, punkt13);
    Punkt punkt14 = Punkt(-1, -1);
    Punkt punkt15 = Punkt(8, 8);
    Odcinek odcinek6 = Odcinek(punkt14, punkt15);
    cout << czy_prostopadle(odcinek5, odcinek6) << endl;

    cout << "Sprawdza czy dwa odcinki (-1, 1)(1, -1) (-1, -1)(8, 8) sa rownolegle" << endl;
    cout << czy_rownolegle(odcinek5, odcinek6) << endl;

    cout << "Sprawdza czy dwa odcinki (10, 5)(15, 5) (2, 2)(8, 2) sa prostopadle" << endl;
    cout << czy_prostopadle(odcinek3, odcinek4) << endl;

    cout << "Sprawdza czy dwa odcinki (4, 5)(6, 5) (12, 4)(8, 2) sa rownolegle" << endl;
    Punkt punkt16 = Punkt(4, 5);
    Punkt punkt17 = Punkt(6, 5);
    Odcinek odcinek7 = Odcinek(punkt16, punkt17);
    Punkt punkt18 = Punkt(12, 4);
    Punkt punkt19 = Punkt(8, 2);
    Odcinek odcinek8 = Odcinek(punkt18, punkt19);
    cout << czy_rownolegle(odcinek7, odcinek8) << endl;

    cout << "Sprawdza czy dwa odcinki (4, 5)(6, 5) (12, 4)(8, 2) sa prostopadle" << endl;
    cout << czy_prostopadle(odcinek7, odcinek8) << endl;


    Punkt punkt20 = Punkt(12, 4);
    Punkt punkt21 = Punkt(8, 2);
    Punkt punkt22 = Punkt(12, 5);
    Trojkat trojkat1 = Trojkat(punkt20, punkt21, punkt22);
    cout << "Pole trojkata(12,4)(8,2)(12,5)" << endl;
    cout << trojkat1.pole() << endl;
    cout << "Obwod trojkata(12,4)(8,2)(12,5)" << endl;
    cout << trojkat1.obwod() << endl;

    odcinek1.przesun_odc(wektor);
    odcinek1.obrot_odc(punkt1, 40);
    odcinek1.sym_odc_punkt(punkt1);
    trojkat1.przesun_trojkat(wektor);
    trojkat1.obrot_trojkat(punkt1, 40);
    trojkat1.sym_trojkat_punkt(punkt1);
    odcinek1.koniec();
    odcinek1.poczatek();
    odcinek1 = odcinek3;
    trojkat1 = trojkat1;
    wektor.wektorX();
    wektor.wektorY();
    Prosta prosta1 = Prosta(4, 5);
    prosta1.wspA();
    prosta1.wspB();
    cout << "Odleglosc miedzy punktem 12, 4 a 8,2" << endl;
    cout << length(punkt20, punkt21) << endl;

    cout << "test operatorow przypisania" << endl;
    cout << punkt1.wspX() << endl;
    cout << punkt22.wspX() << endl;
    punkt1 = punkt22;
    cout << punkt1.wspX() << endl;

    
  


    return 1;
}