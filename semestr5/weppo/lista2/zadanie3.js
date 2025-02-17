console.log((![]+[])[+[]]
+(![]+[])[+!+[]]
+([![]]+[][[]])[+!+[]+[+[]]]
+(![]+[])[!+[]+!+[]]);


//Grupa 1: ![]: ewaluuje sie do false, bo [] ewaluuje sie do true
//+[]: jako, ze ![] nie jest liczba, to binarny + zadziala jak konkatenacja stringow. ![] bedzie zamieniony na "false", [] na "". Otrzymujemy "false"
//[+[]]. zadziala jak unarny +[] i sprobuje zamienic na liczbe. Pusta tablica to liczba 0.
//ta grupa zwroci wiec pierwszy indeks z napisu "false", czyli "f"

//Grupa 2:
//![]+[] to znowu napis "false"
//teraz sprawdzmy +!+[]: +[] daje 0. !+[] daje true, bo negujemy falszywa wartosc (0). +!+[] daje 1, bo unarny + stara sie operowac na liczbach
//druga grupa zwroci wiec "false"[1], czyli "a"

//Grupa 3:
//najpierw ([![]]+[][[]])
//[![]] to [false]
//[][[]] to unidentified, gdyż javascript będzie próbować zamienić tablicę wskazującą na indeks w tablicy na liczbę. Pusta tablica = 0. Mamy więc [][0], ale w pustej tablicy nie ma żadnych elementów.
//dodając składniki do siebie otrzymujemy falseunidentified, gdyż + na obiektach innych niż liczby zamienia je na stringi.

//Czas na +!+[]+[+[]].
//+!+[] ewaluuje sie do 1
//[+[]] ewaluuje sie do [0]
//skoro jeden z argumentow nie jest liczba, to 1 + [0] zadziala jak konkatenacja po zrzucie na stringi i otrzymamy 10.
//falseunidentified[10] = i

//Grupa 4
//![] + [] ewaluuje sie do "false"
//!+[]+!+[]: !+[] ewaluuje sie do true. Mamy wiec true + true, czyli bedziemy chcieli zamienic na liczby. 1 + 1 = 2
//"false"[2] = l

//Wynikiem jest wiec "fail"
