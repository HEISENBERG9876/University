#pragma once
# include "kolory.hpp"
#include <iostream>


class piksel {
	private:
		int x;
		int y;
	protected:
		const static int szerokosc_ekranu = 1920;
		const static int wysokosc_ekranu = 1080;
	public:
		piksel();
		piksel(int nowe_x, int nowe_y);
		
		int dlugosc_do_lewej_gory();
		int dlugosc_do_prawej_gory();
		int dlugosc_do_lewego_dolu();
		int dlugosc_do_prawego_dolu();

		int getX() const;
		int getY() const;
		void setX(int nowe_x);
		void setY(int nowe_y);

		friend std::ostream& operator<<(std::ostream& os, const piksel& p);


};


class pikselkolorowy : public piksel {
private:
	kolortransparentny kolor_piksel;
public:
	pikselkolorowy();
	pikselkolorowy(int nowe_x, int nowe_y, kolortransparentny kolor1);
	void przesun(int wektor_x, int wektor_y);

	void setKolor(kolortransparentny new_kolor);
	kolortransparentny getKolor() const; 

	friend std::ostream& operator<<(std::ostream& os, const pikselkolorowy& p);
};


int odleglosc(const piksel& p, const piksel& q);
int odleglosc(const piksel* p, const piksel* q);
