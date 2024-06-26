package struktury;

public class Para implements Cloneable, Comparable<Para> {
    public final String klucz;
    private double wartosc;

    public Para(String klucz, double wartosc) {
        if(klucz == null || klucz.isEmpty() || !klucz.matches("^[a-z]+$")) {
            throw new IllegalArgumentException("Klucz musi być stringiem zbudowanym ze znaków alfabetu angielskiego");
        }
        this.klucz = klucz;
        this.wartosc = wartosc;
    }

    public double getWartosc() {
        return wartosc;
    }

    public void setWartosc(double wartosc) {
        this.wartosc = wartosc;
    }

    @Override
    public Para clone(){
        try {
            return (Para) super.clone();
        } catch (CloneNotSupportedException e) {
            throw new InternalError(e);
        }
    }

    @Override
    public int compareTo(Para otherPara) {
        return this.klucz.compareTo(otherPara.klucz);
    }

    @Override
    public boolean equals(Object obj){
        if(this == obj){
            return true;
        }

        else if(obj == null || obj.getClass() != getClass()){
            return false;
        }
        else {
            Para otherPara = (Para) obj;
            return klucz.equals(otherPara.klucz);
        }
    }

    @Override
    public String toString(){
        return "Klucz: " + klucz + ", Wartość: " + wartosc;
    }

}
