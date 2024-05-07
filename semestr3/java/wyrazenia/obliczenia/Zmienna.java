package obliczenia;

import struktury.*;

public class Zmienna extends Wyrazenie {
    public static final ZbiorTablicowy wszystkieZmienne = new ZbiorTablicowy(100);
    private final String identyfikator;

    public Zmienna(String identyfikator) {
        this.identyfikator = identyfikator;
    }

    public double oblicz() {
        Para para = wszystkieZmienne.szukaj(identyfikator);
        if(para != null) {
            return para.getWartosc();
        }
        else{
            throw new IllegalArgumentException("Zmiennej nie ma w zbiorze zmiennych");
        }
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
            Zmienna otherZmienna = (Zmienna) obj;
            return this.identyfikator.equals(otherZmienna.identyfikator);
        }
    }

    @Override
    public String toString(){
        return identyfikator;
    }
}
