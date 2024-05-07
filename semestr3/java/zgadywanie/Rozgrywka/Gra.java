package Rozgrywka;

import obliczenia.Wymierna;

public class Gra {
    private int zakres;
    private Wymierna liczba;
    private int maksIloscProb;
    private int licznikProb;
    public int aktualnyStanGry;

    public static final int STAN_NIEAKTYWNY = 0;
    public static final int STAN_AKTYWNY = 1;
    public static final int STAN_REZYGNACJA = 2;
    public static final int STAN_PORAZKA = 3;
    public static final int STAN_ZWYCIESTWO = 4;

    public void start(int z) {
        if (z < 5 || z > 20) {
            throw new IllegalArgumentException("Podaj liczbe z przedzialu 5 : 20.");
        }

        aktualnyStanGry = STAN_AKTYWNY;
        zakres = z;
        int licz, mian;

        do {
            licz = (int) (Math.random() * zakres) + 1;
            mian = (int) (Math.random() * zakres) + 1;
        }while (licz >= mian);

        liczba = new Wymierna(licz, mian);
//        maksIloscProb = (int) Math.ceil(3 - (int)Math.log(z)) + 1;
        maksIloscProb = 10;
        licznikProb = 1;

        assert licz >= mian : "Wylosowana liczba nie byla z przedzialu (0, 1), cos sie popsulo :(";
    }

    public void odgadnij(Wymierna propozycja) {
        if(aktualnyStanGry != STAN_AKTYWNY) {
            throw new IllegalStateException("Gra musi byc aktywna, zeby w nia zagrac.");
        }

        licznikProb++;

        if (propozycja.equals(liczba)) {
            aktualnyStanGry = STAN_ZWYCIESTWO;
        }
        else if (licznikProb >= maksIloscProb) {
            aktualnyStanGry = STAN_PORAZKA;
        }
    }
    public int getMaksIloscProb(){
        return maksIloscProb;
    }

    public int getPozostalaIloscProb(){
        return maksIloscProb - licznikProb;
    }

    public int getLicznikProb(){
        return licznikProb;
    }

    public Wymierna getWymierna() {
        return liczba;
    }
}
