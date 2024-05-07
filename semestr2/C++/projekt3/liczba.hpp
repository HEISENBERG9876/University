#ifndef LICZBA_HPP
#define LICZBA_HPP

class Liczba {
private:
    int max_dlugosc = 3;
    int akt_dlugosc;
    double* historia = nullptr;
    double akt_liczba;
public:
    
    Liczba(double);
    Liczba();
    Liczba(const Liczba&);
    Liczba(Liczba&&);

    
    Liczba& operator=(const Liczba&);
    Liczba& operator=(Liczba&&);
    Liczba& operator=(double);

    
    ~Liczba();


    void PokazHistorie();
    void Cofnij();
    double Wartosc();
 
    
};

#endif