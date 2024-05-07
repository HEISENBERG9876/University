package figury;
public final class Prosta {
    public final double a;
    public final double b;
    public final double c;

    public Prosta(double a, double b, double c){
        if(b == 0){
            throw new IllegalArgumentException("Wspolczynnik B nie moze rownac sie zero :(");
        }
        this.a = a;
        this.b = b;
        this.c = c;
    }
    public static Prosta Przesun(Prosta pr, Wektor w){
        double nowe_c = pr.c  - pr.a * w.dx + pr.b * w.dy;
        return new Prosta(pr.a, pr.b, nowe_c);
    }

    public static boolean CzyRownolegle(Prosta pr1, Prosta pr2){
        double E = 0.0000000000001;
        double r1 = pr1.a / pr1.b;
        double r2 = pr2.a / pr2.b;

        return Math.abs(r1 - r2) < E;
    }

    public static boolean CzyProstopadle(Prosta pr1, Prosta pr2){
        double E = 0.0000000000001;
        double r1 = pr1.a / pr1.b;
        double r2 = pr2.a / pr2.b;

        return Math.abs((r1 * r2) + 1) < E;
    }

    public static Punkt punktPrzeciecia(Prosta pr1, Prosta pr2){
        if (CzyRownolegle(pr1, pr2)){
            throw new IllegalArgumentException("Proste prostopadłe nie mają punktu przecięcia");
        }
        double wyznacznik = pr1.a * pr2.b - pr1.b * pr2.a;
        double x = (pr1.b * pr2.c - pr2.b * pr1.c) / wyznacznik;
        double y = (pr1.c * pr2.a - pr2.c * pr1.a) / wyznacznik;
        return new Punkt(x, y);
    }

}
