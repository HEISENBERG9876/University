package figury;
public class Trojkat {
    protected Punkt p1;
    protected Punkt p2;
    protected Punkt p3;

    public Trojkat(Punkt p1, Punkt p2, Punkt p3){
        if(p1.equals(p2) || p2.equals(p3) || p1.equals(p3)){
            throw new IllegalArgumentException("Punkty w trojkacie nie moga byc takie same");
        }
        double dlp1p2 = Math.sqrt(Math.pow(p1.x - p2.x, 2) + Math.pow(p1.y - p2.y, 2));
        double dlp2p3 = Math.sqrt(Math.pow(p2.x - p3.x, 2) + Math.pow(p2.y - p3.y, 2));
        double dlp1p3 = Math.sqrt(Math.pow(p1.x - p3.x, 2) + Math.pow(p1.y - p3.y, 2));
        if(dlp1p2 + dlp2p3 <= dlp1p3 || dlp1p2 + dlp1p3 <= dlp2p3 || dlp2p3 + dlp1p3 <= dlp1p2){
            throw new IllegalArgumentException("Punkty w trojkacie nie moga byc wspolliniowe");
        }
        this.p1 = p1;
        this.p2 = p2;
        this.p3 = p3;
    }
    public Trojkat przesun(Wektor w){
        return new Trojkat(p1.przesun(w), p2.przesun(w), p3.przesun(w));
    }
    public Trojkat obroc(Punkt p, double kat){
        return new Trojkat(p1.obroc(p, kat), p2.obroc(p, kat),p3.obroc(p, kat));
    }
    public Trojkat odbij(Prosta p){
        return new Trojkat(p1.odbij(p), p2.odbij(p), p3.odbij(p));
    }

    @Override
    public String toString() {
        return p1.toString() + " " + p2.toString() + " " + p3.toString();
    }
}
