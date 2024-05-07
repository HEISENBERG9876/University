package figury;
public final class Wektor {
    public final double dx;
    public final double dy;
    public Wektor(double dx, double dy) {
        this.dx = dx;
        this.dy = dy;
    }
    public static Wektor Zloz(Wektor w1, Wektor w2){
        double w3dx = w1.dx + w2.dx;
        double w3dy = w1.dy + w2.dy;
        return new Wektor(w3dx, w3dy);
    }

    @Override
    public String toString() {
        return "[" + dx + ", " + dy + "]";
    }
}
