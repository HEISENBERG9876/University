import figury.*;

public class Main {
    public static void main(String[] args) {
        Prosta pr1 = new Prosta(0, 1, -1);
        Punkt p1 = new Punkt(1, 1);

        Punkt p1_przes = p1.przesun(new Wektor(0, 0)); //dziala
        Punkt p1_obr = p1.obroc(new Punkt(1, 1), 360); //dziala
        Punkt p1_sym = p1.odbij(pr1); //dziala

        System.out.println(p1_przes.toString());
        System.out.println(p1_obr.toString());
        System.out.println(p1_sym.toString());
        System.out.println();

        Prosta pr2 = new Prosta(2, 3, 7);
        Punkt p2 = new Punkt(3, 4); //symetryczny wzgledem pr 1 to (1 2)

        Punkt p2_przes = p2.przesun(new Wektor(3, 7)); //dziala
        Punkt p2_obr = p2.obroc(new Punkt(1, 2), 265); //dziala
        Punkt p2_sym = p2.odbij(pr2); // chyba dziala

        System.out.println(p2_przes.toString());
        System.out.println(p2_obr.toString());
        System.out.println(p2_sym.toString());

        System.out.println();
        System.out.println(Prosta.punktPrzeciecia(new Prosta(1, 2, 3), new Prosta(6, 7, 8)));

        System.out.println();
        System.out.println(Wektor.Zloz(new Wektor(1, 2), new Wektor(3, 4)));

    }
}