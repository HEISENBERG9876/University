#include <iostream>
#include "liczba.hpp"
using namespace std;


int main()
{
    Liczba liczba = 1;
    cout << "liczba = 1, wypisujemy historie";
    cout << endl;
    liczba.PokazHistorie();
    cout << endl;

    liczba = 2;
    liczba = 3;
    cout << "liczba = 1, liczba = 2, liczba = 3, wypisujemy historie";
    cout << endl;
    liczba.PokazHistorie();
    cout << endl;

    liczba = 4;
    liczba = 5;
    liczba = 6;
    cout << "liczba = 4, liczba = 5, liczba = 6 wypisujemy historie";
    cout << endl;
    liczba.PokazHistorie();
    cout << endl;

    Liczba liczba2 = liczba;
    cout << "liczba2 = liczba, wypisujemy historie liczby2";
    cout << endl;
    liczba2.PokazHistorie();
    cout << endl;

    liczba2.Cofnij();
    cout << "liczba2.cofnij() wypisujemy historie";
    cout << endl;
    liczba2.PokazHistorie();
    cout << endl;


    liczba2.Cofnij();
    liczba2.Cofnij();
    liczba2.Cofnij();
    liczba2.Cofnij();
    liczba2.Cofnij();
    liczba2.Cofnij();
    liczba2.Cofnij();

     cout << "liczba2.cofnij() * 7 wypisujemy historie";
    cout << endl;
    liczba2.PokazHistorie();
    cout << endl;

    liczba2 = 0;
    liczba2 = 8;
    liczba2 = 9;

    Liczba liczba3 = Liczba();
    cout << "Liczba liczba3 = Liczba(); wypisujemy historie";
    cout << endl;
    liczba3.PokazHistorie();
    cout << endl;

    liczba.Wartosc();
    liczba = Liczba(liczba2);
    liczba = liczba2;
    liczba = Liczba(Liczba(1));
    liczba3.Cofnij();
    cout << endl;

    return 0;
}