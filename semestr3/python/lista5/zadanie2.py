from abc import abstractmethod
from itertools import product


class Formula:
    def __add__(self, w2):  # w1, w2 to obiekty klasy Formula.
        if not isinstance(w2, Formula):
            raise InvalidFormulaError("Operacja + dziala tylko na poprawnych formulach typu Formula")
        return Or(self, w2)

    def __mul__(self, w2):
        if not isinstance(w2, Formula):
            raise InvalidFormulaError("Operacja * dziala tylko na poprawnych formulach typu Formula")
        return And(self, w2)

    def tautologia(self):
        nazwy_zmiennych = self.zwroc_nazwy_zmiennych()  # wszystkie nazwy zmiennych w formule
        kombinacje = product([True, False], repeat=len(nazwy_zmiennych))  # generuje kazda mozliwa kombinacje true/false
        # o dlugosci rownej ilosci zmiennych w formule, dzieki czemu zmiennym mozemy przypisywac kolejne wartosciowania.

        return all(self.oblicz(dict(zip(nazwy_zmiennych, kombinacja))) for kombinacja in kombinacje)

    @abstractmethod
    def __str__(self):
        pass

    @abstractmethod
    def oblicz(self, zmienne):
        pass

    @abstractmethod
    def uprosc(self):
        pass

    @abstractmethod
    def zwroc_nazwy_zmiennych(self):
        pass


class Zmienna(Formula):
    def __init__(self, nazwa):
        if not isinstance(nazwa, str):
            raise ValueError("Nazwa zmiennej przy instancjonowaniu obiektu klasy Zmienna musi byc typu string")
        self.nazwa = nazwa

    def __str__(self):
        return self.nazwa

    def oblicz(self, zmienne):
        if self.nazwa in zmienne:
            return zmienne[self.nazwa]
        else:
            raise NotAssignedError(f'Zmienna "{self.nazwa}" nie zostala przypisana do wartosci.')

    def uprosc(self):  # zmiennej nie mozna uproscic dalej, podobnie jak stalej
        return self

    def zwroc_nazwy_zmiennych(self):
        return {self.nazwa}


class Stala(Formula):
    def __init__(self, wartosc):
        if not isinstance(wartosc, bool):
            raise ValueError("Wartosc stalej przy instancjonowaniu obiektu klasy Stala musi byc wartoscia logiczna")
        self.wartosc = wartosc

    def __str__(self):
        return str(self.wartosc)

    def oblicz(self, zmienne):
        return self.wartosc

    def uprosc(self):
        return self

    def zwroc_nazwy_zmiennych(self):
        return set()


class Not(Formula):
    def __init__(self, w1):
        if not isinstance(w1, Formula):
            raise InvalidFormulaError("Niepoprawna formula przy instancjonowaniu obiektu klasy Not")
        self.w1 = w1

    def __str__(self):
        return f'¬{self.w1}' if isinstance(self.w1, (Zmienna, Stala, Not)) else f'¬({self.w1})'  # brak nawiasu przy formulach atomowych

    def oblicz(self, zmienne):
        return not self.w1.oblicz(zmienne)

    def uprosc(self):
        w1_uproszczone = self.w1.uprosc()
        if isinstance(w1_uproszczone, Stala):
            return Stala(not w1_uproszczone.oblicz({}))
        else:
            return Not(w1_uproszczone)

    def zwroc_nazwy_zmiennych(self):
        return self.w1.zwroc_nazwy_zmiennych()


class Or(Formula):
    def __init__(self, w1, w2):
        if not isinstance(w1, Formula) or not isinstance(w2, Formula):
            raise InvalidFormulaError("Niepoprawna formula przy instancjonowaniu obiektu klasy Or")
        self.w1 = w1
        self.w2 = w2

    def __str__(self):
        str_w1 = f'{self.w1}' if isinstance(self.w1, (Zmienna, Stala, Not)) else f'({self.w1})'
        str_w2 = f'{self.w2}' if isinstance(self.w2, (Zmienna, Stala, Not)) else f'({self.w2})'
        return f'{str_w1} ∨ {str_w2}'

    def oblicz(self, zmienne):
        return self.w1.oblicz(zmienne) or self.w2.oblicz(zmienne)

    def uprosc(self):
        w1_uproszczone = self.w1.uprosc()
        w2_uproszczone = self.w2.uprosc()
        if isinstance(w1_uproszczone, Stala):
            return w2_uproszczone if not w1_uproszczone.oblicz({}) else w1_uproszczone
        elif isinstance(w2_uproszczone, Stala):
            return w1_uproszczone if not w2_uproszczone.oblicz({}) else w2_uproszczone
        else:
            return Or(w1_uproszczone, w2_uproszczone)

    def zwroc_nazwy_zmiennych(self):
        return self.w1.zwroc_nazwy_zmiennych() | self.w2.zwroc_nazwy_zmiennych()


class And(Formula):
    def __init__(self, w1, w2):
        if not isinstance(w1, Formula) or not isinstance(w2, Formula):
            raise InvalidFormulaError("Niepoprawna formula przy instancjonowaniu obiektu klasy And")
        self.w1 = w1
        self.w2 = w2

    def __str__(self):
        str_w1 = f'{self.w1}' if isinstance(self.w1, (Zmienna, Stala, Not)) else f'({self.w1})'
        str_w2 = f'{self.w2}' if isinstance(self.w2, (Zmienna, Stala, Not)) else f'({self.w2})'
        return f'{str_w1} ∧ {str_w2}'

    def oblicz(self, zmienne):
        return self.w1.oblicz(zmienne) and self.w2.oblicz(zmienne)

    def uprosc(self):
        w1_uproszczone = self.w1.uprosc()
        w2_uproszczone = self.w2.uprosc()
        if isinstance(w1_uproszczone, Stala):
            return w1_uproszczone if not w1_uproszczone.oblicz({}) else w2_uproszczone
        elif isinstance(w2_uproszczone, Stala):
            return w2_uproszczone if not w2_uproszczone.oblicz({}) else w1_uproszczone
        else:
            return And(w1_uproszczone, w2_uproszczone)

    def zwroc_nazwy_zmiennych(self):
        return self.w1.zwroc_nazwy_zmiennych() | self.w2.zwroc_nazwy_zmiennych()


class Implication(Formula):
    def __init__(self, w1, w2):
        if not isinstance(w1, Formula) or not isinstance(w2, Formula):
            raise InvalidFormulaError("Niepoprawna formula przy instancjonowaniu obiektu klasy Implication")
        self.w1 = w1
        self.w2 = w2

    def __str__(self):
        str_w1 = f'{self.w1}' if isinstance(self.w1, (Zmienna, Stala, Not)) else f'({self.w1})'
        str_w2 = f'{self.w2}' if isinstance(self.w2, (Zmienna, Stala, Not)) else f'({self.w2})'
        return f'{str_w1} => {str_w2}'

    def oblicz(self, zmienne):
        return True if not self.w1.oblicz(zmienne) else self.w2.oblicz(zmienne)

    def uprosc(self):
        w1_uproszczone = self.w1.uprosc()
        w2_uproszczone = self.w2.uprosc()
        if isinstance(w1_uproszczone, Stala):
            return w2_uproszczone if w1_uproszczone.oblicz({}) else Stala(True)
        else:
            return Implication(w1_uproszczone, w2_uproszczone)

    def zwroc_nazwy_zmiennych(self):
        return self.w1.zwroc_nazwy_zmiennych() | self.w2.zwroc_nazwy_zmiennych()


# ERRORY
class NotAssignedError(Exception):
    def __init__(self, message):
        self.message = message
        super().__init__(self.message)


class InvalidFormulaError(Exception):
    def __init__(self, message):
        self.message = message
        super().__init__(self.message)


# TESTY
zmienne = {
    "x": True,
    "y": False
}

t = Stala(True)
f = Stala(False)

x = Zmienna("x")
y = Zmienna("y")

w1 = Not(t)
w2 = And(t, f)
w3 = Or(t, f)
w4 = Implication(f, t)
w5 = Implication(t, f)

w6 = Or(x, t)
w7 = Or(x, f)
w8 = And(x, t)
w9 = And(x, f)
w10 = Implication(f, x)
w11 = Implication(t, x)
w12 = Implication(x, f)
w13 = Implication(x, t)
w14 = And(Or(t, x), And(y, t))

w16 = Or(t, x)
w17 = Or(f, x)
w18 = And(t, x)
w19 = And(f, x)

w20 = Or(x, y)
w21 = And(x, y)
w22 = Not(x)
w23 = Implication(x, y)
w24 = And(x, Or(x, x))

w25 = And(x, Or(y, Not(y)))
w26 = And(Or(x, Not(x)), Or(y, Not(y)))
w27 = Implication(And(Implication(x, y), x), x)


print('zmienne: x = True, y = False')
print('x = Zmienna(x), y = Zmienna(y)')
print('t = Stala(True), f = Stala(False)')
print()

print(f'{w25} * {w25} = {w25 * w25}')
print(f'{w16} * {w18} = {w16 * w18}')
print()

print(f'Obliczenie {t}: {t.oblicz(zmienne)}')
print(f'Obliczenie {f}: {f.oblicz(zmienne)}')
print(f'Obliczenie {w1}: {w1.oblicz(zmienne)}')
print(f'Obliczenie {w2}: {w2.oblicz(zmienne)}')
print(f'Obliczenie {w3}: {w3.oblicz(zmienne)}')
print(f'Obliczenie {w4}: {w4.oblicz(zmienne)}')
print(f'Obliczenie {w5}: {w5.oblicz(zmienne)}')
print()

print(f'Uproszczenie {w6}: {w6.uprosc()}')
print(f'Uproszczenie {w7}: {w7.uprosc()}')
print(f'Uproszczenie {w8}:  {w8.uprosc()}')
print(f'Uproszczenie {w9}:  {w9.uprosc()}')
print(f'Uproszczenie {w16}:  {w16.uprosc()}')
print(f'Uproszczenie {w17}:  {w17.uprosc()}')
print(f'Uproszczenie {w18}:  {w18.uprosc()}')
print(f'Uproszczenie {w19}: {w19.uprosc()}')
print(f'Uproszczenie {w10}:  {w10.uprosc()}')
print(f'Uproszczenie {w11}: {w11.uprosc()}')
print(f'Uproszczenie {w12}:  {w12.uprosc()}')
print(f'Uproszczenie {w13}: {w13.uprosc()}')
print(f'Uproszczenie {w14}:  {w14.uprosc()}')
print(f'Uproszczenie {w20}: {w20.uprosc()}')
print(f'Uproszczenie {w21}: {w21.uprosc()}')
print(f'Uproszczenie {w22}: {w22.uprosc()}')
print(f'Uproszczenie {w23}: {w23.uprosc()}')
print()

print(f'Nazwy zmiennych w formule {w24}: {w24.zwroc_nazwy_zmiennych()}')
print(f'Nazwy zmiennych w formule {w20}: {w20.zwroc_nazwy_zmiennych()}')
print()

print(f'Czy formula {w6} to tautologia? {w6.tautologia()}')
print(f'Czy formula {w7} to tautologia? {w7.tautologia()}')
print(f'Czy formula {w25} to tautologia? {w25.tautologia()}')
print(f'Czy formula {w26} to tautologia? {w26.tautologia()}')
print(f'Czy formula {w27} to tautologia? {w27.tautologia()}')
print(f'Czy formula {x} to tautologia? {x.tautologia()}')
print(f'Czy formula {t} to tautologia? {t.tautologia()}')
print(f'Czy formula {f} to tautologia? {f.tautologia()}')
# chyba wszystko się zgadza
