import struktury.*;
import obliczenia.*;

public class Main {
    public static void main(String[] args) throws CloneNotSupportedException {
        Zmienna.wszystkieZmienne.wstaw(new Para("x", 1.618));
        Wyrazenie x = new Zmienna("x");

        Wyrazenie w = new Dodaj(
                new Liczba(7.2),
                new Mnoz(
                        new Zmienna("x"),
                        new Liczba(2.4)
                )
        );

        //testy
        System.out.println(w);
        System.out.println(w.oblicz());
        System.out.println();

        double iloczyn = Wyrazenie.iloczyn(w, w, w);
        System.out.println("Iloczyn poprzedniego wyrazenia * 3");
        System.out.println(iloczyn);
        System.out.println();

        double suma = Wyrazenie.suma(w, w, w);
        System.out.println("Suma poprzedniego wyrazenia 3 razy");
        System.out.println(suma);
        System.out.println();

        Wyrazenie pi = new Pi();
        Wyrazenie e = new E();


        Wyrazenie w2 = new Odejm(
                new Dodaj(
                        new Liczba(7),
                        new Mnoz(new Liczba(5), new Liczba(3))),
                new Liczba(1)
                );

        System.out.println("Wyrazenie:");
        System.out.println(w2);
        System.out.println("Wynik:");
        System.out.println(w2.oblicz());
        System.out.println();

        Wyrazenie w3 = new Mnoz(
                new Przec(new Odejm(
                        new Liczba(2),
                        x)),
                e
                );

        System.out.println("Wyrazenie:");
        System.out.println(w3);
        System.out.println("Wynik:");
        System.out.println(w3.oblicz());
        System.out.println();

        Wyrazenie w4 = new Dziel(
                new Odejm(
                        new Mnoz(
                                new Liczba(3),
                                pi),
                        new Liczba(1)
                ),
                new Dodaj(
                        x,
                        new Liczba(5)
                )
        );

        System.out.println("Wyrazenie:");
        System.out.println(w4);
        System.out.println("Wynik:");
        System.out.println(w4.oblicz());
        System.out.println();

    Wyrazenie w5 = new Dziel(
            new Mnoz(
                    new Sin(
                            new Dodaj(
                                    x,
                                    new Liczba(13)
                            )
                    ),
                    pi
            ),
            new Odejm(
                    new Liczba(1),
                    x
            )
    );

        System.out.println("Wyrazenie:");
        System.out.println(w5);
        System.out.println("Wynik:");
        System.out.println(w5.oblicz());
        System.out.println();

        Wyrazenie w6 = new Dodaj(
                new Exp(
                        new Liczba(5)
                ),
                new Mnoz(
                        x,
                        new Log(
                                e,
                                x
                        )
                )
        );

        System.out.println("Wyrazenie:");
        System.out.println(w6);
        System.out.println("Wynik:");
        System.out.println(w6.oblicz());
        System.out.println();

        System.out.println();
        System.out.println("TESTY KLONOWANIA");
        Para para1 = new Para("x", 1);
        Para para2 = para1.clone();
        System.out.println("para1:");
        System.out.println(para1);
        System.out.println("para2 = para1.clone()");
        System.out.println(para2);
        System.out.println();

        para2.setWartosc(2);

        System.out.println("Zmieniamy pare 2 na x = 2 i sprawdzamy czy para1 sie zmieni:");
        System.out.println("para1:");
        System.out.println(para1);
        System.out.println("para2");
        System.out.println(para2);
        System.out.println();
        System.out.println("Klonowanie par działa tak jak powinno. Sprawdźmy klonowanie zbiorów");
        System.out.println();

        Para para3 = new Para("y", 5);
        Para para4 = new Para("z", -5);

        ZbiorTablicowy zbior1 = new ZbiorTablicowy(5);
        zbior1.wstaw(para1);
        zbior1.wstaw(para2);
        ZbiorTablicowy zbior2 = zbior1.clone();

        System.out.println("Zbior1:");
        System.out.println(zbior1);
        System.out.println("Zbior2 = zbior1.clone()");
        System.out.println(zbior2);
        System.out.println();

        zbior2.wstaw(para3);

        System.out.println("Sprawdzamy, czy zmiany na zbior 1 nie maja wplywu na zbior 2");
        System.out.println("Zbior1:");
        System.out.println(zbior1);
        System.out.println("Zbior2:");
        System.out.println(zbior2);
        System.out.println("Klonowanie zbiorow dziala jak powinno");




    }
}