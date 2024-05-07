#ifndef CLASSES_HPP
#define CLASSES_HPP

#include <iostream>
#include <cmath>
#include <stdexcept>
using namespace std;


class Wektor {
private:
    double X;
    double Y;
public:
    Wektor(double x, double y) {
        X = x;
        Y = y;
    }
    double wektorX() {
        return X;
    }
    double wektorY() {
        return Y;
    }
};


class Prosta {
private:
    double A;
    double B;
public:
    Prosta(double a, double b) {
        A = a;
        B = b;
    }
    double wspA() {
        return A;
    }
    double wspB() {
        return B;
    }


};


class Punkt {
private:
    double X;
    double Y;
public:
    Punkt(double x, double y) {
        X = x;
        Y = y;
    }
    Punkt(const Punkt& p) {
        X = p.X;
        Y = p.Y;
    }
    Punkt& operator=(const Punkt& p) {
        X = p.X;
        Y = p.Y;
        return *this;
    }

    double wspX() {
        return X;
    }

    double wspY() {
        return Y;
    }

    void wypiszWsp() {
        cout << "X: " << X << ", " << "Y: " << Y << endl;
    }

    Punkt przesun(Wektor& w) {
        return Punkt(X + w.wektorX(), Y + w.wektorY());
    }

    Punkt obrot(Punkt& p, double kat) {
        double sin_k = sin(kat);
        double cos_k = cos(kat);

        double x_pom = X - p.X;
        double y_pom = Y - p.Y;

        x_pom = x_pom * cos_k - y_pom * sin_k;
        y_pom = x_pom * sin_k + y_pom * cos_k;

        return Punkt(x_pom + p.X, y_pom + p.Y);
    }

    Punkt sym_punkt(Punkt& srodek) {
        return Punkt(-1 * X + 2 * srodek.X, -1 * Y + 2 * srodek.Y);
    }

};


double length(Punkt& punkt1, Punkt& punkt2) {
    double x1 = punkt1.wspX();
    double x2 = punkt2.wspX();
    double y1 = punkt1.wspY();
    double y2 = punkt2.wspY();

    return sqrt(pow(x1 - x2, 2) + pow(y1 - y2, 2));
}


class Odcinek {
private:
    Punkt p1;
    Punkt p2;
public:
    Odcinek(Punkt P1, Punkt P2) : p1(P1), p2(P2) {
        if (p1.wspX() == p2.wspX() && p1.wspY() == p2.wspY()) {
            throw std::invalid_argument("nie mozna utworzyc odcinka o dlugosci 0");
        }
    }

    Odcinek(const Odcinek& o) : p1(o.p1), p2(o.p2) {}

    Odcinek& operator=(const Odcinek& o) {
        p1 = o.p1;
        p2 = o.p2;
        return *this;
    }

    double len_odc() {
        return length(p1, p2);
    }

    Punkt poczatek() {
        return p1;
    }

    Punkt koniec() {
        return p2;
    }

    Odcinek przesun_odc(Wektor& w) {
        return Odcinek(p1.przesun(w), p2.przesun(w));
    }

    Odcinek obrot_odc(Punkt& p, double kat) {
        return Odcinek(p1.obrot(p, kat), p2.obrot(p, kat));
    }

    Odcinek sym_odc_punkt(Punkt& srodek) {
        return Odcinek(p1.sym_punkt(srodek), p2.sym_punkt(srodek));
    }

    bool czy_na_odcinku(Punkt& p) {
        double epsilon = 0.00001;
        double dystans1 = this->len_odc();
        double dystans2 = length(p, p1);
        double dystans3 = length(p, p2);

        return abs(dystans2 + dystans3 - dystans1) < epsilon;
    }

};


bool czy_rownolegle(Odcinek& o1, Odcinek& o2) {
    double epsilon = 0.0001;
    double o1p1x = o1.poczatek().wspX();
    double o1p1y = o1.poczatek().wspY();
    double o1p2x = o1.koniec().wspX();
    double o1p2y = o1.koniec().wspY();

    double o2p1x = o2.poczatek().wspX();
    double o2p1y = o2.poczatek().wspY();
    double o2p2x = o2.koniec().wspX();
    double o2p2y = o2.koniec().wspY();

    double nachylenie1 = (o1p2y - o1p1y) / (o1p2x - o1p1x);
    double nachylenie2 = (o2p2y - o2p1y) / (o2p2x - o2p1x);

    if ((abs(o1p2x - o1p1x) < epsilon) && abs(o2p2x - o2p1x) < epsilon) {
        return 1;
    }

    if ((abs(o2p2x - o2p1x) < epsilon)) {
        return 0;
    }

    if ((abs(o1p2x - o1p1x) < epsilon)) {
        return 0;
    }
    else {
        return (abs(nachylenie1 - nachylenie2) < epsilon);
    }
}


bool czy_prostopadle(Odcinek& o1, Odcinek& o2) {
    double epsilon = 0.0001;

    double o1p1x = o1.poczatek().wspX();
    double o1p1y = o1.poczatek().wspY();
    double o1p2x = o1.koniec().wspX();
    double o1p2y = o1.koniec().wspY();

    double o2p1x = o2.poczatek().wspX();
    double o2p1y = o2.poczatek().wspY();
    double o2p2x = o2.koniec().wspX();
    double o2p2y = o2.koniec().wspY();

    double nachylenie1 = (o1p2y - o1p1y) / (o1p2x - o1p1x);
    double nachylenie2 = (o2p2y - o2p1y) / (o2p2x - o2p1x);

    if ((abs(o1p2x - o1p1x) < epsilon) && abs(o2p2y - o2p1y) < epsilon) {
        return 1;
    }

    if ((abs(o2p2x - o2p1x) < epsilon) && abs(o1p2y - o1p1y) < epsilon) {
        return 1;
    }

    if ((abs(o2p2x - o2p1x) < epsilon)) {
        return 0;
    }

    if ((abs(o1p2x - o1p1x) < epsilon)) {
        return 0;
    }
    else {
        return (nachylenie1 * nachylenie2 + 1) < epsilon;
    }
}


class Trojkat {
private:
    Punkt p1;
    Punkt p2;
    Punkt p3;
public:
    Trojkat(Punkt P1, Punkt P2, Punkt P3) : p1(P1), p2(P2), p3(P3) {
        if ((p1.wspX() == p2.wspX() && p1.wspY() == p2.wspY()) ||
            (p1.wspX() == p3.wspX() && p1.wspY() == p3.wspY()) ||
            (p2.wspX() == p3.wspX() && p2.wspY() == p3.wspY())) {
            throw std::invalid_argument("Długości boków trójkąta muszą być większe niż 0");
        }
        double epsilon = 0.0001;
        double dlugosc1 = length(p1, p2);
        double dlugosc2 = length(p1, p3);
        double dlugosc3 = length(p2, p3);

        double roznica1 = abs(dlugosc1 + dlugosc2 - dlugosc3);
        double roznica2 = abs(dlugosc1 + dlugosc3 - dlugosc2);
        double roznica3 = abs(dlugosc2 + dlugosc3 - dlugosc1);

        if ((roznica1 < epsilon) || (roznica2 < epsilon) || (roznica2 < epsilon)) {
            throw std::invalid_argument("Boki trojkata nie moga byc wspolliniowe");
        }
    }

    Trojkat(const Trojkat& t) : p1(t.p1), p2(t.p2), p3(t.p3) {}

    Trojkat& operator=(const Trojkat& t) {
        p1 = t.p1;
        p2 = t.p2;
        p3 = t.p3;
        return *this;
    }

    double obwod() {
        double dl1 = length(p1, p2);
        double dl2 = length(p2, p3);
        double dl3 = length(p3, p1);
        return dl1 + dl2 + dl3;
    }

    double pole() {
        double x1 = p1.wspX();
        double x2 = p2.wspX();
        double x3 = p3.wspX();
        double y1 = p1.wspY();
        double y2 = p2.wspY();
        double y3 = p3.wspY();
        double pole = abs((1.000000001 / 2.00000001) * (x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2)));
        return pole;
    }

    Trojkat przesun_trojkat(Wektor& w) {
        return Trojkat(p1.przesun(w), p2.przesun(w), p3.przesun(w));
    }

    Trojkat obrot_trojkat(Punkt& p, double kat) {
        return Trojkat(p1.obrot(p, kat), p2.obrot(p, kat), p3.obrot(p, kat));
    }

    Trojkat sym_trojkat_punkt(Punkt& srodek) {
        return Trojkat(p1.sym_punkt(srodek), p2.sym_punkt(srodek), p3.sym_punkt(srodek));
    }
};

#endif