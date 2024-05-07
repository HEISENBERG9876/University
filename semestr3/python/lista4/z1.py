from timeit import timeit


def pierwsze_imperatywna(n):
    result = []
    for liczba in range(2, n + 1):
        czy_pierwsza = True
        for dzielnik in range(2, int((liczba ** 0.5)) + 1): # dla tez 2 zwroci true, bo w range(2, 2) nie ma zadnych liczb.
            if liczba % dzielnik == 0:
                czy_pierwsza = False
                break
        if czy_pierwsza:
            result.append(liczba)
    return result


def pierwsze_skladana(n):
    # return [liczba for liczba in range(2, n + 1) if not [dzielnik for dzielnik in range(2, int((liczba ** 0.5)) + 1) if liczba % dzielnik == 0]] # tez dziala, ale wolno
    return [liczba for liczba in range(2, n + 1) if all(liczba % dzielnik != 0 for dzielnik in range(2, int(liczba ** 0.5) + 1))]


def pierwsze_funkcyjna(n):
    def czy_pierwsza(liczba):
        for dzielnik in range(2, int((liczba ** 0.5)) + 1):
            if liczba % dzielnik == 0:
                return False
        return True
    return list(filter(czy_pierwsza, range(2, n + 1)))


def zmierz_czas(funkcja, argument):
    stmt = f"{funkcja}({argument})"
    return timeit(stmt, setup=f"from __main__ import {funkcja}", number=1)


def drukuj_tabelke(n):
    row_width = 12
    print(f"{'n' + (row_width - 1) * ' '}imperat.    skladana    funkcyjna")
    for i in range(1, 10): # dane bede mnozyl max. * 9, żeby ułatwić sobie formatowaniu tabelki.
        dane = n * i
        result_line = f"{dane}{' ' * (row_width - len(str(dane)))}"
        w1 = str(round(zmierz_czas("pierwsze_imperatywna", dane), 6))
        w2 = str(round(zmierz_czas("pierwsze_skladana", dane), 6))
        w3 = str(round(zmierz_czas("pierwsze_funkcyjna", dane), 6))
        w1 = w1 + (row_width - len(w1)) * ' '
        w2 = w2 + (row_width - len(w2)) * ' '
        w3 = w3 + (row_width - len(w3)) * ' '
        result_line += w1 + w2 + w3
        print(result_line)
        print()
    print()


drukuj_tabelke(1000)

print("pozostale testy")
print("Dla n = 20")
print(pierwsze_imperatywna(20))
print(pierwsze_skladana(20))
print(pierwsze_funkcyjna(20))
print()

print("Dla n = 2")
print(pierwsze_imperatywna(2))
print(pierwsze_skladana(2))
print(pierwsze_funkcyjna(2))
print()

print("Dla n = 1")
print(pierwsze_imperatywna(1))
print(pierwsze_skladana(1))
print(pierwsze_funkcyjna(1))
print()

print("Dla n = 0")
print(pierwsze_imperatywna(0))
print(pierwsze_skladana(0))
print(pierwsze_funkcyjna(0))
print()

print("Dla n = 129")
print(pierwsze_imperatywna(129))
print(pierwsze_skladana(129))
print(pierwsze_funkcyjna(129))
print()

print("Dla n = -129")
print(pierwsze_imperatywna(-129))
print(pierwsze_skladana(-129))
print(pierwsze_funkcyjna(-129))
print()

print("Dla n = 18")
print(pierwsze_imperatywna(18))
print(pierwsze_skladana(18))
print(pierwsze_funkcyjna(18))