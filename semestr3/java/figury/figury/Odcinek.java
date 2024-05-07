package figury;
public class Odcinek {
    protected Punkt p1;
    protected Punkt p2;

    public Odcinek(Punkt p1, Punkt p2) {
        if (p1.equals(p2)) {
            throw new IllegalArgumentException("Odcinek nie moze miec dlugosci rownej 0 :(");
        }
        this.p1 = p1;
        this.p2 = p2;
    }
    public Odcinek przesun(Wektor w){
        return new Odcinek(p1.przesun(w), p2.przesun(w));
    }
    public Odcinek obroc(Punkt p, double kat){
        return new Odcinek(p1.obroc(p, kat), p2.obroc(p, kat));
    }
    public Odcinek odbij(Prosta p){
        return new Odcinek(p1.odbij(p), p2.odbij(p));
    }

    @Override
    public String toString() {
        return p1.toString() + " " + p2.toString();
    }
}
