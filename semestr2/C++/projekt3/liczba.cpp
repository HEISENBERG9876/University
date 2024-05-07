#include "liczba.hpp"
#include <iostream>


Liczba::Liczba(double liczba){
    akt_dlugosc = 1;
    akt_liczba = liczba;
    historia = new double[3];
    historia[0] = liczba;
}

Liczba::Liczba() : Liczba(0) {
}

Liczba::Liczba(Liczba&& liczba) {
    akt_dlugosc = liczba.akt_dlugosc;
    akt_liczba = liczba.akt_liczba;
    historia = liczba.historia;
    liczba.historia = nullptr;

}


Liczba::Liczba(const Liczba& liczba) {
    akt_dlugosc = liczba.akt_dlugosc;
    akt_liczba = liczba.akt_liczba;
    historia = new double[akt_dlugosc];

    for (int i = 0; i < liczba.akt_dlugosc; i++)
    {
        historia[i] = liczba.historia[i];
    }
}



Liczba::~Liczba() {
    if (historia != nullptr){
	    delete[] historia;
    }
}



Liczba& Liczba::operator=(const Liczba& liczba) {
    delete[] historia;
    akt_dlugosc = liczba.akt_dlugosc;
    akt_liczba = liczba.akt_liczba;
    historia = new double[akt_dlugosc];
    for (int i = 0; i < akt_dlugosc; i++)
    {
        historia[i] = liczba.historia[i];
    }
    return *this;

}


Liczba& Liczba::operator=(Liczba&& liczba){
    delete[] historia;
    akt_dlugosc = liczba.akt_dlugosc;
    akt_liczba = liczba.akt_liczba;
    historia = liczba.historia;
    liczba.historia = nullptr;
    return *this;

}


Liczba& Liczba::operator=(double liczba) {
    akt_liczba = liczba;
    if (akt_dlugosc == max_dlugosc) {
        for (int i = 1; i < max_dlugosc; i++) {
            historia[i - 1] = historia[i];
        }
        historia[max_dlugosc - 1] = liczba;

    }
    else {
        akt_dlugosc += 1;
        historia[akt_dlugosc - 1] = liczba;
    }
    return *this;
}


void Liczba::Cofnij() {
    if (akt_dlugosc > 1) {
        akt_dlugosc -= 1;
        akt_liczba = historia[akt_dlugosc - 1];
    }
}

void Liczba::PokazHistorie() {
    for (int i = 0; i < akt_dlugosc; i++) {
        std::cout << historia[i] << std::endl;
    }
}

double Liczba::Wartosc(){
    return historia[akt_dlugosc - 1];
}
