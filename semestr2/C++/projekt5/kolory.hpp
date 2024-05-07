#pragma once
#include <iostream>

class kolor {
	private:
		uint8_t red;
		uint8_t green;
		uint8_t blue;
	
	public:
		kolor();
		kolor(int R, int G, int B);

		int getRed() const;
		int getGreen() const;
		int getBlue() const;

		void setRed(int new_value);
		void setGreen(int new_value);
		void setBlue(int new_value);

		void przyciemnij(int procent);
		void rozjasnij(int procent);

		static kolor polacz(kolor kolor1, kolor kolor2);

		friend std::ostream& operator<<(std::ostream& os, const kolor& k);
};


class kolortransparentny : virtual public kolor {
	private:
		uint8_t alfa;

	public:
		kolortransparentny();
		kolortransparentny(int R, int G, int B, int A);
		int getAlfa() const;
		void setAlfa(int new_value);

		friend std::ostream& operator<<(std::ostream& os, const kolortransparentny& kolor1);
};


class kolornazwany : virtual public kolor {
	private:
		std::string nazwa;
	public:
		kolornazwany();
		kolornazwany(int R, int G, int B, std::string nowa_nazwa);

		std::string getNazwa() const;
		void setNazwa(std::string new_nazwa);

		friend std::ostream& operator<<(std::ostream& os, const kolornazwany& kolor1);
	};


class kolornt : public kolornazwany, public kolortransparentny {
	public:
		kolornt();
		kolornt(int R, int G, int B, int A, std::string nazwa);
		friend std::ostream& operator<<(std::ostream& os, const kolornt& kolor1);
};