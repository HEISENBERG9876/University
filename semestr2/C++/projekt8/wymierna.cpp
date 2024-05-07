#include "wymierna.hpp"

namespace obliczenia {
	int NWD(int a, int b) {
		if (b == 0) {
			return a;
		}
		return NWD(b, a % b);
	}

	void wymierna::normalizuj() noexcept {
		int nwd   = NWD(licznik, mianownik);
		licznik   = licznik / nwd;
		mianownik = mianownik / nwd;

		if (mianownik < 0) {
			licznik   = licznik * (-1);
			mianownik = mianownik * (-1);
		}
	}

    wymierna::wymierna() noexcept : licznik(0), mianownik(1){}

	wymierna::wymierna(int licznik, int mianownik) : licznik(licznik), mianownik(mianownik){
        if (mianownik == 0) {
            throw dzielenie_przez_0();
        }
		normalizuj();
	}

    wymierna::wymierna(int liczba) noexcept : wymierna(liczba, 1){}



    std::ostream& operator<< (std::ostream& wyjscie, const wymierna& w) noexcept {
        int licznik   = w.licznik;
        int mianownik = w.mianownik;

        if (licznik == 0) {
            return wyjscie << 0;
        }

        if (licznik < 0 ^ mianownik < 0) {
            wyjscie << "-";
        }

        licznik   = abs(licznik);
        mianownik = abs(mianownik);

        int czesc_calkowita = licznik / mianownik;
        int reszta = licznik % mianownik;
        std::string czesc_ulamkowa = "";
        std::map<int, int> poprz_reszty;

        wyjscie << czesc_calkowita << ".";

        while (reszta != 0 && poprz_reszty.find(reszta) == poprz_reszty.end()) {
            poprz_reszty[reszta] = czesc_ulamkowa.length();
            reszta    = reszta * 10;
            int cyfra = reszta/ mianownik;
            reszta    = reszta % mianownik;
            czesc_ulamkowa += std::to_string(cyfra);
        }

        if (poprz_reszty.find(reszta) != poprz_reszty.end()) {
            int start_powtarzania_i = poprz_reszty[reszta];
            czesc_ulamkowa = czesc_ulamkowa.substr(0, start_powtarzania_i) + "(" + czesc_ulamkowa.substr(start_powtarzania_i) + ")";
        }

        if (czesc_ulamkowa == "") {
            wyjscie << 0;
        }
        else {
            wyjscie << czesc_ulamkowa;
        }

        return wyjscie;
    }

    int wymierna::getLicznik() const noexcept {
        return licznik;
    }
    int wymierna::getMianownik() const noexcept {
        return mianownik;
    }

    void check_int_overflow(int64_t liczba) {
        if (liczba > std::numeric_limits<int>::max() || liczba < std::numeric_limits<int>::min()) {
            throw przekroczenie_zakresu();
        }
    }

    wymierna wymierna::operator-() const noexcept{
        int nowy_licznik = this->licznik * -1;
        return wymierna(nowy_licznik, this->mianownik);
    }

    wymierna wymierna::operator!() const {
        if (this->licznik == 0) {
            throw dzielenie_przez_0();
        }
        int nowy_licznik = mianownik;
        int nowy_mianownik = licznik;
        return wymierna(nowy_licznik, nowy_mianownik);
    }

    wymierna wymierna::operator+(const wymierna& liczba) const {
        int64_t nowy_licznik   = int64_t(this->licznik * liczba.mianownik) + int64_t(liczba.licznik * this->mianownik);
        int64_t nowy_mianownik = int64_t(this->mianownik * liczba.mianownik);
        
        check_int_overflow(nowy_licznik);
        check_int_overflow(nowy_mianownik);

        return wymierna(int(nowy_licznik), int(nowy_mianownik));
    }

    wymierna wymierna::operator-(const wymierna& liczba) const {
        int64_t nowy_licznik   = int64_t(this->licznik * liczba.mianownik) - int64_t(liczba.licznik * this->mianownik);
        int64_t nowy_mianownik = int64_t(this->mianownik * liczba.mianownik);

        check_int_overflow(nowy_licznik);
        check_int_overflow(nowy_mianownik);

        return wymierna(int(nowy_licznik), int(nowy_mianownik));
    }

    wymierna wymierna::operator*(const wymierna& liczba) const {
        int64_t nowy_licznik   = int64_t(this->licznik * liczba.licznik);
        int64_t nowy_mianownik = int64_t(this->mianownik * liczba.mianownik);

        check_int_overflow(nowy_licznik);
        check_int_overflow(nowy_mianownik);

        return wymierna(int(nowy_licznik), int(nowy_mianownik));
    }

    wymierna wymierna::operator/(const wymierna& liczba) const {
        if (liczba.licznik == 0){
            throw dzielenie_przez_0();
        }
        int64_t nowy_licznik   = int64_t(this->licznik * liczba.mianownik);
        int64_t nowy_mianownik = int64_t(this->mianownik * liczba.licznik);

        check_int_overflow(nowy_licznik);
        check_int_overflow(nowy_mianownik);

        return wymierna(int(nowy_licznik), int(nowy_mianownik));
    }

    wymierna::operator double() const noexcept {
        return double(licznik) / double(mianownik);
    }

    wymierna::operator int() const noexcept {
        return licznik / mianownik;
    }
}