package obliczenia;

public class Wymierna implements Comparable<Wymierna>{
    private int licznik, mianownik = 1;

    public Wymierna(){
        this.licznik = 0;
    }

    public Wymierna(int n){
        this(n, 1);
    }

    public Wymierna(int k, int m){
        if(m == 0){
            throw new IllegalArgumentException("Mianownik nie moze byc rowny 0");
        }
        int gcd = gcd(Math.abs(k), Math.abs(m));
        k = k / gcd;
        m = m / gcd;
        if(m < 0){
            this.licznik = -k;
            this.mianownik = -m;
        }
        else {
            this.licznik = k;
            this.mianownik = m;
        }
    }

    public int getLicznik(){
        return licznik;
    }

    public int getMianownik(){
        return mianownik;
    }

    private int gcd(int a, int b) {
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }

    public static Wymierna Dodaj(Wymierna w1, Wymierna w2){
        int nowy_licznik = w1.getLicznik() * w2.getMianownik() + w2.getLicznik() * w1.getMianownik();
        int nowy_mianownik = w1.getMianownik() * w2.getMianownik();
        return new Wymierna(nowy_licznik, nowy_mianownik);
    }

    public static Wymierna Odejmij(Wymierna w1, Wymierna w2){
        int nowy_licznik = w1.getLicznik() * w2.getMianownik() - w2.getLicznik() * w1.getMianownik();
        int nowy_mianownik = w1.getMianownik() * w2.getMianownik();
        return new Wymierna(nowy_licznik, nowy_mianownik);
    }

    public static Wymierna Pomnoz(Wymierna w1, Wymierna w2){
        int nowy_licznik = w1.getLicznik() * w2.getLicznik();
        int nowy_mianownik = w1.getMianownik() * w2.getMianownik();
        return new Wymierna(nowy_licznik, nowy_mianownik);
    }

    public static Wymierna Podziel(Wymierna w1, Wymierna w2){
        if(w2.getLicznik() == 0){
            throw new ArithmeticException("Nie mozna dzielic przez 0");
        }
        int nowy_licznik = w1.getLicznik() * w2.getMianownik();
        int nowy_mianownik = w1.getMianownik() * w2.getLicznik();
        return new Wymierna(nowy_licznik, nowy_mianownik);
    }

    @Override
    public int compareTo(Wymierna wymierna2) {
        int iloczyn1 = this.licznik * wymierna2.getMianownik();
        int iloczyn2 = wymierna2.getLicznik() * this.mianownik;

        return Integer.compare(iloczyn1, iloczyn2);
    }

    @Override
    public boolean equals(Object obj){
        if(this == obj){
            return true;
        }
        else if(obj == null || this.getClass() != obj.getClass()){
            return false;
        }
        else{
            Wymierna otherWymierna = (Wymierna) obj;
            return this.licznik == otherWymierna.getLicznik() && this.mianownik == otherWymierna.getMianownik();
        }
    }

    @Override
    public String toString(){
        return "(" + licznik + "/" + mianownik + ")";
    }
}
