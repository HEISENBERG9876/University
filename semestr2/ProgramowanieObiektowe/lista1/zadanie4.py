def tabliczka(x1, x2, y1, y2, skok):
    rzedy = int((y2 - y1) / skok) + 1
    kolumny = int((x2 - x1) / skok) + 1
    dl_liczb = max(len(str(y1)), len(str(x1))) - 1
    szerokosc_kol = dl_liczb + 2

    print(' ' * (szerokosc_kol + 1), end=' ')
    for kol in range(kolumny):
        liczba = x1 + kol * skok
        print(f'{liczba:.{dl_liczb}f}', end=' ')
    print()

    for rzad in range(rzedy):
        liczba_y = y1 + rzad * skok
        print(f'{liczba_y:.{dl_liczb}f}:', end=' ')

        for kol in range(kolumny):
            liczba_x = x1 + kol * skok
            wynik = liczba_x * liczba_y
            print(f'{wynik:.{dl_liczb}f}', end=' ')
        print()


tabliczka(0.2, 1.3, 0.2, 3.14, 0.3)
