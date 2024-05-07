#include "kolory.hpp"
#include <iostream>


//KOLOR
kolor::kolor() {
	red   = 0;
	green = 0;
	blue  = 0;
}


kolor::kolor(int R, int G, int B) {
    if (R < 0 || R > 255 || G < 0 || G > 255 || B < 0 || B > 255) {
        throw std::invalid_argument("Kolory musz� by� liczbami pomi�dzy 0 i 255.");
    }
    else {
        red = R;
        green = G;
        blue = B;
    }
}


int kolor::getRed() const {
    return red;
}


int kolor::getGreen() const{
    return green;
}


int kolor::getBlue() const{
    return blue;
}


void kolor::setRed(int new_value) {
    if (new_value < 0 || new_value > 255) {
        throw std::invalid_argument("Kolory musz� by� liczbami pomi�dzy 0 i 255.");
    }
    else {
        red = new_value;
    }

}


void kolor::setGreen(int new_value) {
    if (new_value < 0 || new_value > 255) {
        throw std::invalid_argument("Kolory musz� by� liczbami pomi�dzy 0 i 255.");
    }
    else {
        green = new_value;
    }
}


void kolor::setBlue(int new_value) {
    if (new_value < 0 || new_value > 255) {
        throw std::invalid_argument("Kolory musz� by� liczbami pomi�dzy 0 i 255.");
    }
    else {
        blue = new_value;
    }
}


void kolor::przyciemnij(int procent) {
    float mnoznik = 1 - procent / 100.0;
    red   = std::max(0, (int)(red * mnoznik));
    green = std::max(0, (int)(green * mnoznik));
    blue  = std::max(0, (int)(blue * mnoznik));
}


void kolor::rozjasnij(int procent) {
    float mnoznik = 1 + procent / 100.0;
    red   = std::min(255, (int)(red * mnoznik));
    green = std::min(255, (int)(green * mnoznik));
    blue  = std::min(255, (int)(blue * mnoznik));
}

kolor kolor::polacz(kolor kolor1, kolor kolor2) {
    int new_red   = (int)((kolor1.getRed()   + kolor2.getRed())   / 2);
    int new_green = (int)((kolor1.getGreen() + kolor2.getGreen()) / 2);
    int new_blue  = (int)((kolor1.getBlue()  + kolor2.getBlue())  / 2);
    return kolor(new_red, new_green, new_blue);
}

std::ostream& operator<<(std::ostream& os, const kolor& kolor1) {
    os << kolor1.getRed() << ", " << kolor1.getGreen() << ", " << kolor1.getBlue() << std::endl;
    return os;
}


//KOLOR TRANSPARENTNY
kolortransparentny::kolortransparentny() : kolor(), alfa(0) {}


kolortransparentny::kolortransparentny(int R, int G, int B, int A) : kolor(R, G, B), alfa(A){
    if (A < 0 || A > 255) {
        throw std::invalid_argument("Alfa musi byc liczba pomiedzy 0 i 255.");
    }
}


int kolortransparentny::getAlfa() const {
    return alfa;
}


void kolortransparentny::setAlfa(int new_value) {
    if (new_value < 0 || new_value > 255) {
        throw std::invalid_argument("Alfa musi byc liczba pomiedzy 0 i 255.");
    }
    else {
        alfa = new_value;
    }
}


std::ostream& operator<<(std::ostream& os, const kolortransparentny& kolor1) {
    os << kolor1.getRed() << ", " << kolor1.getGreen() << ", " << kolor1.getBlue() << ", alfa: " << kolor1.getAlfa() << std::endl;
    return os;
}



//KOLOR NAZWANY
kolornazwany::kolornazwany() : kolor(), nazwa("") {}

kolornazwany::kolornazwany(int R, int G, int B, std::string nowa_nazwa) : kolor(R, G, B), nazwa(nowa_nazwa) {}

std::string kolornazwany::getNazwa() const {
    return nazwa;
}

void kolornazwany::setNazwa(std::string nowa_nazwa) {
    nazwa = nowa_nazwa;
}

std::ostream& operator<<(std::ostream& os, const kolornazwany& kolor1) {
    os << "RGB: " << kolor1.getRed() << ", " << kolor1.getGreen() << ", " << kolor1.getBlue() << ", nazwa: " << kolor1.getNazwa() << std::endl;
    return os;
}


//KOLORNT

kolornt::kolornt() : kolornazwany(), kolortransparentny() {}
kolornt::kolornt(int R, int G, int B, int A, std::string nazwa) : kolor(R, G, B), kolornazwany(R, G, B, nazwa), kolortransparentny(R, G, B, A){}

std::ostream& operator<<(std::ostream& os, const kolornt& kolor1) {
    os << "RGB: " << kolor1.getRed() << ", " << kolor1.getGreen() << ", " << kolor1.getBlue() << ", alfa: " << kolor1.getAlfa() <<
        ", nazwa: " << kolor1.getNazwa() << std::endl;

    return os;
}