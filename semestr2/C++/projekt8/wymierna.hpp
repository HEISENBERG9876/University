#pragma once
#include <iostream>
#include <string>
#include <map>
#include <limits>

namespace obliczenia {
	class wymierna {
	private:
		int licznik;
		int mianownik;
		void normalizuj() noexcept;
	public:
		wymierna() noexcept;
		wymierna(int licznik, int mianownik);
		wymierna(int liczba) noexcept;
		int getLicznik() const noexcept;
		int getMianownik() const noexcept;
		wymierna operator-() const noexcept;
		wymierna operator!() const;
		wymierna operator+(const wymierna& liczba) const;
		wymierna operator-(const wymierna& liczba) const;
		wymierna operator*(const wymierna& liczba) const;
		wymierna operator/(const wymierna& liczba) const;
		operator double() const noexcept;
		explicit operator int() const noexcept;
		friend std::ostream& operator<< (std::ostream& wyjscie, const wymierna& w) noexcept;
	};

	class wyjatek_wymierny : public std::logic_error {
	public:
		wyjatek_wymierny(const std::string& msg) : std::logic_error(msg) {}
	};

	class dzielenie_przez_0 : public wyjatek_wymierny {
	public:
		dzielenie_przez_0()
			: wyjatek_wymierny("Dzielenie przez zero") {}
	};

	class przekroczenie_zakresu : public wyjatek_wymierny {
	public:
		przekroczenie_zakresu()
			: wyjatek_wymierny("Dzielenie przez zero") {}
	};

}