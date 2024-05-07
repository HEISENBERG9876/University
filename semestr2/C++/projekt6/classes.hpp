#pragma once
#include <iostream>
#include <vector>
#include <cmath>
#include <string>
#include <iomanip>



class wyrazenie{
private:
    wyrazenie(const wyrazenie&) = delete;
    wyrazenie& operator=(const wyrazenie&) = delete;
    wyrazenie(const wyrazenie&&) = delete;
    wyrazenie& operator=(const wyrazenie&&) = delete;
public:
    wyrazenie() {};
    virtual double oblicz() = 0;
    virtual std::string zapis() = 0;
    virtual int priorytet();
    virtual bool lewostronne();
    virtual ~wyrazenie() {};
};


class liczba final : public wyrazenie {
protected:
    double wartosc;
public:
    liczba(double wartosc);
    double oblicz() override;
    std::string zapis() override;
};


class zmienna final : public wyrazenie {
private:
    static std::vector<std::pair<std::string, double>> zmienne;
    std::string nazwa;
public:
    zmienna(std::string nazwa);

    static void dodajZmienna(std::string nazwa, double wartosc);
    static void usunZmienna(std::string nazwa);
    static void modyfikujZmienna(std::string nazwa, double wartosc);

    double oblicz() override;
    std::string zapis() override;
};


class stala : public wyrazenie {
public:
    stala(double wartosc);
    double wartosc;
};


class pi final : public stala{
public:
    pi();
    double oblicz() override;
    std::string zapis() override;
};

class e final : public stala{
public:
    e();
    double oblicz() override;
    std::string zapis() override;
};

class operator_jedno_arg : public wyrazenie {
protected:
    wyrazenie* arg1;
public:
    operator_jedno_arg(wyrazenie* arg1);
};


class zmiana_znaku : public operator_jedno_arg {
public:
    zmiana_znaku(wyrazenie* arg1);
    double oblicz() override;
    std::string zapis() override;
};


class sinus : public operator_jedno_arg {
public:
    sinus(wyrazenie* arg1);
    double oblicz() override;
    std::string zapis() override;
};


class cosinus : public operator_jedno_arg {
public:
    cosinus(wyrazenie* arg1);
    double oblicz() override;
    std::string zapis() override;
};


class operator_dwu_arg : public operator_jedno_arg {
protected:
    wyrazenie* arg2;
public:
    operator_dwu_arg(wyrazenie* arg1, wyrazenie* arg2);
};


class dodawanie : public operator_dwu_arg {
public:
    dodawanie(wyrazenie* arg1, wyrazenie* arg2);
    double oblicz() override;
    std::string zapis() override;
    int priorytet() override { return 40; };
};


class odejmowanie : public operator_dwu_arg {
public:
    odejmowanie(wyrazenie* arg1, wyrazenie* arg2);
    double oblicz() override;
    std::string zapis() override;
    int priorytet() override { return 40; };
};


class mnozenie : public operator_dwu_arg {
public:
    mnozenie(wyrazenie* arg1, wyrazenie* arg2);
    double oblicz() override;
    std::string zapis() override;
    int priorytet() override { return 80; };
};


class dzielenie : public operator_dwu_arg {
public:
    dzielenie(wyrazenie* arg1, wyrazenie* arg2);
    double oblicz() override;
    std::string zapis() override;
    int priorytet() override { return 80; };
};


class potegowanie : public operator_dwu_arg {
public:
    potegowanie(wyrazenie* arg1, wyrazenie* arg2);
    double oblicz() override;
    std::string zapis() override;
    int priorytet() override { return 100; };
};


class logarytm : public operator_dwu_arg {
public:
    logarytm(wyrazenie* arg1, wyrazenie* arg2);
    double oblicz() override;
    std::string zapis() override;
};