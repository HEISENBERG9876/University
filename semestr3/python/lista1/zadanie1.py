from decimal import Decimal

lista = [0.41, 0.67]
lista2 = [Decimal("10.50"), Decimal("15.75"), Decimal("20.00")]


def paragon(lista):
    suma = 0
    for cena in lista:
        suma += 0.23 * cena
    return suma


def faktura(lista):
    suma = 0
    for cena in lista:
        suma += cena
    return 0.23 * suma


def paragon2(lista):
    suma = Decimal("0")
    for cena in lista:
        suma += Decimal("0.23") * Decimal(str(cena))
    return suma


def faktura2(lista):
    suma = Decimal("0")
    for cena in lista:
        suma += Decimal(str(cena))
    return Decimal("0.23") * suma


print(paragon(lista) == faktura(lista))
print(paragon2(lista2) == faktura2(lista2))

