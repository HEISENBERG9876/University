from math import gcd


def nowy_ulamek(num, denom):
    nwd = gcd(num, denom)
    num = int(num / nwd)
    denom = int(denom / nwd)
    return num, denom


def show(u):
    print(f'{u[0]}/{u[1]}')


def dodaj(ulamek1, ulamek2):
    num = ulamek1[0] * ulamek2[1] + ulamek2[0] * ulamek1[1]
    denom = ulamek1[1] * ulamek2[1]
    return nowy_ulamek(num, denom)


def odejmij(ulamek1, ulamek2):
    num = ulamek1[0] * ulamek2[1] - ulamek2[0] * ulamek1[1]
    denom = ulamek1[1] * ulamek2[1]
    return nowy_ulamek(num, denom)


def pomnoz(ulamek1, ulamek2):
    num = ulamek1[0] * ulamek2[0]
    denom = ulamek1[1] * ulamek2[1]
    return nowy_ulamek(num, denom)


def podziel(ulamek1, ulamek2):
    num = ulamek1[0] * ulamek2[1]
    denom = ulamek1[1] * ulamek2[0]
    return nowy_ulamek(num, denom)
