package obliczenia;

public abstract class Wyrazenie implements Obliczalny{
    public static double suma (Wyrazenie... wyr){ //zamienilem int na double
        double wynik = 0;
        for(Wyrazenie w : wyr){
            wynik += w.oblicz();
        }
        return wynik;
    }

    public static double iloczyn (Wyrazenie... wyr) {
        double wynik = 1;
        for(Wyrazenie w : wyr){
            wynik *= w.oblicz();
        }
        return wynik;

    }

    public abstract double oblicz();

    protected int getPriorytet(){
        return 20;
    }

}