#include "piksele.hpp"
#include <iostream>
#include <cmath>


piksel::piksel() {
	x = 0;
	y = 0;
}


piksel::piksel(int nowe_x, int nowe_y) {
	if (nowe_x < 0 || nowe_x > szerokosc_ekranu || nowe_y < 0 || nowe_y > wysokosc_ekranu) {
		throw std::invalid_argument("Piksel musi miescic sie na ekranie");
	}
	else {
		x = nowe_x;
		y = nowe_y;
	}
}


int piksel::dlugosc_do_lewego_dolu() {
	//do 0/0
	return (int)(sqrt(x * x + y * y));
}


int piksel::dlugosc_do_prawego_dolu() {
	//do szerokosc/0
	int szerokosc = piksel::szerokosc_ekranu;
	int wysokosc  = piksel::wysokosc_ekranu;
	int dx        = x - szerokosc;
	return (int)(sqrt(dx * dx + y * y));
}


int piksel::dlugosc_do_prawej_gory() {
	//do szerokosc/wysokosc
	int szerokosc = piksel::szerokosc_ekranu;
	int wysokosc  = piksel::wysokosc_ekranu;
	int dx        = x - szerokosc;
	int dy        = y - wysokosc;
	return (int)(sqrt(dx * dx + dy * dy));
}


int piksel::dlugosc_do_lewej_gory() {
	//do 0/wysokosc
	int szerokosc = piksel::szerokosc_ekranu;
	int wysokosc  = piksel::wysokosc_ekranu;
	int dy        = y - wysokosc;
	return (int)(sqrt(x * x + dy * dy));
}


int piksel::getX() const{
	return x;
}


int piksel::getY() const{
	return y;
}


void piksel::setX(int nowe_x) {
	if (nowe_x < 0 || nowe_x > szerokosc_ekranu) {
		throw std::invalid_argument("Piksel musi miescic sie na ekranie");
	}
	else {
		x = nowe_x;
	}
}


void piksel::setY(int nowe_y) {
	if (nowe_y < 0 || nowe_y > wysokosc_ekranu) {
		throw std::invalid_argument("Piksel musi miescic sie na ekranie");
	}
	else {
		y = nowe_y;
	}
}


//PIKSEL KOLOROWY
pikselkolorowy::pikselkolorowy() : piksel(), kolor_piksel(kolortransparentny()) {
}


pikselkolorowy::pikselkolorowy(int nowe_x, int nowe_y, kolortransparentny kolor1) : piksel(nowe_x, nowe_y), kolor_piksel(kolor1){
}


void pikselkolorowy::przesun(int wektor_x, int wektor_y) {
	int szerokosc = pikselkolorowy::szerokosc_ekranu;
	int wysokosc  = pikselkolorowy::wysokosc_ekranu;
	if (getX() + wektor_x < 0 || getX() + wektor_x > szerokosc || getY() + wektor_y < 0 || getY() + wektor_y > wysokosc) {
		throw std::invalid_argument("Przesuniety piksel musi miescic sie na ekranie.");
	}
	else {
		setX(getX() + wektor_x);
		setY(getY() + wektor_y);
	}
}


void pikselkolorowy::setKolor(kolortransparentny new_kolor){
	kolor_piksel = new_kolor;
}


kolortransparentny pikselkolorowy::getKolor() const{
	return kolor_piksel;
}
	 

int odleglosc(const piksel& p, const piksel& q){
	int dx = p.getX() - q.getX();
	int dy = p.getY() - q.getY();
	return (int)(sqrt(dx * dx + dy * dy));
}
int odleglosc(const piksel* p, const piksel* q) {
	int dx = p->getX() - q->getX();
	int dy = p->getY() - q->getY();
	return (int)(sqrt(dx * dx + dy * dy));
}


std::ostream& operator<<(std::ostream& os, const piksel& p) {
    os << "X: " << p.getX() << " Y: " << p.getY() << std::endl;

    return os;
}


std::ostream& operator<<(std::ostream& os, const pikselkolorowy& p) {
    os << "X: " << p.getX() << " Y: " << p.getY() << " kolor: " << p.getKolor() << std::endl;

    return os;
}