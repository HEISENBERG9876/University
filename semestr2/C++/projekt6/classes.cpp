#include "classes.hpp"

std::vector<std::pair<std::string, double>> zmienna::zmienne;


//wyrazenie
int wyrazenie::priorytet() {
	return 10; //wartosc bazowa dla zmiennych, stalych i funkcji jednoarg, ktorych nie chcemy nawiasowac.
}

bool wyrazenie::lewostronne() {
	return true;
}


//liczba
liczba::liczba(double wartosc) : wartosc(wartosc) {}

double liczba::oblicz() {
	return wartosc;
}

std::string liczba::zapis() {
	return std::to_string(wartosc);
}



//zmienna
zmienna::zmienna(std::string nazwa) : nazwa(nazwa) {}

double zmienna::oblicz() {
	try {
		int ilosc_zmiennych = zmienna::zmienne.size();

		for (int i = 0; i < ilosc_zmiennych; i++)
		{
			if (zmienna::zmienne[i].first == nazwa)
			{
				return zmienne[i].second;
			}
		}
		throw std::runtime_error("Zmiennej nie ma na liscie zmiennych");
	}
	catch (const std::runtime_error& e) {
		std::cerr << e.what() << std::endl;
	}
	// return std::numeric_limits<double>::quiet_NaN();
	return 1;
}

std::string zmienna::zapis() {
	return nazwa;
}

void zmienna::dodajZmienna(std::string nazwa, double wartosc) {
	for (const auto& pair : zmienna::zmienne) {
		if (pair.first == nazwa) {
			return;
		}
	}
	zmienna::zmienne.push_back(make_pair(nazwa, wartosc));
}

void zmienna::usunZmienna(std::string nazwa) {
	try {
		int ilosc_zmiennych = zmienna::zmienne.size();

		for (int i = 0; i < ilosc_zmiennych; i++)
		{
			if (zmienna::zmienne[i].first == nazwa)
			{
				zmienna::zmienne.erase(zmienna::zmienne.begin() + i);
				return;
			}
		}
		throw std::runtime_error("Zmiennej nie ma na liscie zmiennych");
	}

	catch (const std::runtime_error& e) {
		std::cerr << e.what() << std::endl;
	}
}

void zmienna::modyfikujZmienna(std::string nazwa, double wartosc) {
	try {
		int ilosc_zmiennych = zmienna::zmienne.size();

		for (int i = 0; i < ilosc_zmiennych; i++)
		{
			if (zmienna::zmienne[i].first == nazwa)
			{
				zmienna::zmienne[i] = make_pair(nazwa, wartosc);
				return;
			}
		}
		throw std::runtime_error("Zmiennej nie ma na liscie zmiennych");
	}

	catch (const std::runtime_error& e) {
		std::cerr << e.what() << std::endl;
	}
}


//stale
stala::stala(double wartosc) : wartosc(wartosc) {}


pi::pi() : stala(3.14159265359) {}

double pi::oblicz() {
	return wartosc;
}

std::string pi::zapis() {
	return "pi";
}


e::e() : stala(2.71828182846) {}

double e::oblicz() {
	return wartosc;
}

std::string e::zapis() {
	return "e";
}


//operatory i funkcje jednoargumentowe

operator_jedno_arg::operator_jedno_arg(wyrazenie* arg1) : arg1(arg1) {}


zmiana_znaku::zmiana_znaku(wyrazenie* arg1) : operator_jedno_arg(arg1) {}

double zmiana_znaku::oblicz() {
	return arg1->oblicz() * -1;
}

std::string zmiana_znaku::zapis() {
	return "(-" + arg1->zapis() + ")";
}


sinus::sinus(wyrazenie* arg1) : operator_jedno_arg(arg1) {}

double sinus::oblicz() {
	return sin(arg1->oblicz());
}

std::string sinus::zapis() {
	return "sin(" + arg1->zapis() + ")";
}


cosinus::cosinus(wyrazenie* arg1) : operator_jedno_arg(arg1) {}

double cosinus::oblicz() {
	return cos(arg1->oblicz());
}

std::string cosinus::zapis() {
	return "cos(" + arg1->zapis() + ")";
}


//operatory i funkcje dwuargumentowe
operator_dwu_arg::operator_dwu_arg(wyrazenie* arg1, wyrazenie* arg2) : operator_jedno_arg(arg1), arg2(arg2){}


dodawanie::dodawanie(wyrazenie* arg1, wyrazenie* arg2) : operator_dwu_arg(arg1, arg2){}

double dodawanie::oblicz() {
	return arg1->oblicz() + arg2->oblicz();
}

std::string dodawanie::zapis() {
	//przypadki dla zmiennych/stalych/funkcji jednoarg. Nie chcemy ich nawiasowac.
	if (arg1->priorytet() <= 10 && arg2->priorytet() <= 10){
		return arg1->zapis() + "+" + arg2->zapis();
	}
	else if (arg1->priorytet() <= 10) {
		return arg1->zapis() + "+(" + arg2->zapis() + ")";
	}
	else if (arg2->priorytet() <= 10){
		return "(" + arg1->zapis() + ")+" + arg2->zapis();
	}
	//przypadki dla bardziej zlozonych wyrazen, np. skladajacych sie z f dwuargumentowych
	else{
		std::string lewy;
		std::string prawy;

	 	if (arg1->priorytet() < priorytet()){
			lewy = "(" + arg1->zapis() + ")";
		}
		else{
			lewy = arg1->zapis();
		}

		if (arg2->priorytet() < priorytet()){
			prawy = "(" + arg2->zapis() + ")";
		}
		else{
			prawy = arg2->zapis();
		}

		return lewy + "+" + prawy;
	}
}

odejmowanie::odejmowanie(wyrazenie* arg1, wyrazenie* arg2) : operator_dwu_arg(arg1, arg2){}

double odejmowanie::oblicz() {
	return arg1->oblicz() - arg2->oblicz();
}

std::string odejmowanie::zapis() {
	if (arg1->priorytet() <= 10 && arg2->priorytet() <= 10){
		return arg1->zapis() + "-" + arg2->zapis();
	}
	else if (arg1->priorytet() <= 10) {
		return arg1->zapis() + "-(" + arg2->zapis() + ")";
	}
	else if (arg2->priorytet() <= 10){
		return "(" + arg1->zapis() + ")-" + arg2->zapis();
	}
	else{
		std::string lewy;
		std::string prawy;

	 	if (arg1->priorytet() < priorytet()){
			lewy = "(" + arg1->zapis() + ")";
		}
		else{
			lewy = arg1->zapis();
		}

		if (arg2->priorytet() < priorytet()){
			prawy = "(" + arg2->zapis() + ")";
		}
		else{
			prawy = arg2->zapis();
		}

		return lewy + "-" + prawy;
	}
}


mnozenie::mnozenie(wyrazenie* arg1, wyrazenie* arg2) : operator_dwu_arg(arg1, arg2) {}

double mnozenie::oblicz() {
	return arg1->oblicz() * arg2->oblicz();
}

std::string mnozenie::zapis() {
	if (arg1->priorytet() <= 10 && arg2->priorytet() <= 10){
		return arg1->zapis() + "*" + arg2->zapis();
	}
	else if (arg1->priorytet() <= 10) {
		return arg1->zapis() + "*(" + arg2->zapis() + ")";
	}
	else if (arg2->priorytet() <= 10){
		return "(" + arg1->zapis() + ")*" + arg2->zapis();
	}
	else{
		std::string lewy;
		std::string prawy;

	 	if (arg1->priorytet() < priorytet()){
			lewy = "(" + arg1->zapis() + ")";
		}
		else{
			lewy = arg1->zapis();
		}

		if (arg2->priorytet() < priorytet()){
			prawy = "(" + arg2->zapis() + ")";
		}
		else{
			prawy = arg2->zapis();
		}

		return lewy + "*" + prawy;
	}
}


dzielenie::dzielenie(wyrazenie* arg1, wyrazenie* arg2) : operator_dwu_arg(arg1, arg2) {}

double dzielenie::oblicz() {
	try {
		if (arg2->oblicz() == 0) {
			throw std::runtime_error("Nie mozna dzielic przez 0");
		}
		return arg1->oblicz() / arg2->oblicz();
	}
	catch (std::runtime_error& e) {
		std::cerr << e.what() << std::endl;
	}
	return 1;
}

std::string dzielenie::zapis() {
	if (arg1->priorytet() <= 10 && arg2->priorytet() <= 10){
		return arg1->zapis() + "/" + arg2->zapis();
	}
	else if (arg1->priorytet() <= 10) {
		return arg1->zapis() + "/(" + arg2->zapis() + ")";
	}
	else if (arg2->priorytet() <= 10){
		return "(" + arg1->zapis() + ")/" + arg2->zapis();
	}
	else{
		std::string lewy;
		std::string prawy;

	 	if (arg1->priorytet() < priorytet()){
			lewy = "(" + arg1->zapis() + ")";
		}
		else{
			lewy = arg1->zapis();
		}

		if (arg2->priorytet() < priorytet()){
			prawy = "(" + arg2->zapis() + ")";
		}
		else{
			prawy = arg2->zapis();
		}

		return lewy + "/" + prawy;
	}
}


potegowanie::potegowanie(wyrazenie* arg1, wyrazenie* arg2) : operator_dwu_arg(arg1, arg2){}

double potegowanie::oblicz() {
	return pow(arg1->oblicz(), arg2->oblicz());
}

std::string potegowanie::zapis() {
	if (arg1->priorytet() <= 10 && arg2->priorytet() <= 10){
		return arg1->zapis() + "^" + arg2->zapis();
	}
	else if (arg1->priorytet() <= 10) {
		return arg1->zapis() + "^(" + arg2->zapis() + ")";
	}
	else if (arg2->priorytet() <= 10){
		return "(" + arg1->zapis() + ")+" + arg2->zapis();
	}
	else{
		std::string lewy;
		std::string prawy;

	 	if (arg1->priorytet() < priorytet()){
			lewy = "(" + arg1->zapis() + ")";
		}
		else{
			lewy = arg1->zapis();
		}

		if (arg2->priorytet() < priorytet()){
			prawy = "(" + arg2->zapis() + ")";
		}
		else{
			prawy = arg2->zapis();
		}

		return lewy + "^" + prawy;
	}
}



logarytm::logarytm(wyrazenie* arg1, wyrazenie* arg2) : operator_dwu_arg(arg1, arg2) {}

//korzystamy z log_b(x) = log_e(x) / log_e(b)
double logarytm::oblicz() {
	try {
		if (arg1->oblicz() <= 0 || arg1->oblicz() == 1) {
			throw std::runtime_error("Podstawa logarytmu musi byc wieksza od 0 i rozna od 1.");
		}
		if (arg2->oblicz() <= 0) {
			throw std::runtime_error("Liczba logarytmowana musi byc wieksza od 0.");
		}
		double log1 = log(arg1->oblicz());
		double log2 = log(arg2->oblicz());
		return log1 / log2;
	}
	catch(std::runtime_error& e) {
		std::cerr << e.what() << std::endl;
	}
		return 1;
}

std::string logarytm::zapis() {
	return "log(" + arg1->zapis() + "," + arg2->zapis() + ")";
}
