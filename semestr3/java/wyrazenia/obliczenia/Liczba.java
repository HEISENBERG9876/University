package obliczenia;

public class Liczba extends Wyrazenie{
    public double wartosc;

    public Liczba(double wartosc){
        this.wartosc = wartosc;
    }

    public double oblicz(){
        return wartosc;
    }

    @Override
    public boolean equals(Object obj){
        if(obj == this){
            return true;
        }
        else if(obj == null || obj.getClass() != getClass()){
            return false;
        }
        else{
            Liczba otherLiczba = (Liczba) obj;
            return otherLiczba.wartosc == this.wartosc;
        }
    }

    @Override
    public String toString(){
        return Double.toString(wartosc);
    }
}
