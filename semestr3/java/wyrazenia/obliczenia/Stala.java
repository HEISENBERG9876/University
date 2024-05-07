package obliczenia;

public class Stala extends Wyrazenie{
    public String identyfikator;
    public double wartosc;

    public Stala(String identyfikator, double wartosc){
        this.identyfikator = identyfikator;
        this.wartosc = wartosc;
    }

    @Override
    public double oblicz(){
        return wartosc;
    }

    @Override
    public boolean equals(Object obj){
        if(this == obj){
            return true;
        }
        else if(obj == null || obj.getClass() != getClass()){
            return false;
        }
        else{
            Stala otherStala = (Stala) obj;
            return this.identyfikator.equals(otherStala.identyfikator);
        }
    }

    @Override
    public String toString(){
        return identyfikator;
    }
}
