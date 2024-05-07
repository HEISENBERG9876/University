#nullable disable


class Wektor{

    public float[] wspolrzedne;
    public int wymiar;

    public Wektor(int w){
        this.wspolrzedne = new float[w];
        this.wymiar = w;
    }

    public void UstawWspolrzedne(params float[] wsp){
        if (wsp.Length != wymiar){
            throw new ArgumentException("Ilość liczb musi być taka sama jak wymiar wektora.");
        }

        for (int i = 0; i < wsp.Length; i++){
            this.wspolrzedne[i] = wsp[i];
        }
    }
    

     public static Wektor operator +(Wektor w1, Wektor w2){
        if (w1.wymiar != w2.wymiar){
            throw new ArgumentException("Wektory mają różny wymiar.");
        }

        Wektor wynik = new Wektor(w1.wymiar);

        for (int i = 0; i < w1.wymiar; i++){
            wynik.wspolrzedne[i] = w1.wspolrzedne[i] + w2.wspolrzedne[i];
        }

        return wynik;
     }

    public static Wektor operator *(float skalar, Wektor w){
        Wektor wynik = new Wektor(w.wymiar);

        for (int i = 0; i < w.wymiar; i++)
        {
            wynik.wspolrzedne[i] = skalar * w.wspolrzedne[i];
        }

        return wynik;
    }

     public static float operator *(Wektor w1, Wektor w2){
        if (w1.wymiar != w2.wymiar){
            throw new ArgumentException("Wektory mają różny wymiar.");
        }

        float wynik = 0;

        for (int i = 0; i < w1.wymiar; i++){
            wynik += w1.wspolrzedne[i] * w2.wspolrzedne[i];
        }

        return wynik;
     }


    public void WyswietlWspolrzedne(){
         for (int i = 0; i < wymiar; i++){
            Console.Write(wspolrzedne[i]);
            Console.Write(" ");
         }
    Console.WriteLine("");
    }

public float Norma(){
        float dlugosc = 4.0f;
         return dlugosc;
    }
};


class Zadanie4 {
    static void Main(){
        Wektor wektor1 = new Wektor(3);
        wektor1.UstawWspolrzedne(4.5f, 3.0f, 5.0f);
        wektor1.WyswietlWspolrzedne();

        Wektor wektor2 = new Wektor(3);
        wektor2.UstawWspolrzedne(4.8f, 3.0f, 6.3f);
        wektor2.WyswietlWspolrzedne();
        Wektor wektor3 = 4 * wektor2;
        wektor3.WyswietlWspolrzedne();
        float wektor4 = wektor1 * wektor2;
        Console.WriteLine(wektor4);
    }
};
