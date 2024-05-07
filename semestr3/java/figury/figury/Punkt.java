package figury;
public class Punkt {
    protected double x;
    protected double y;

    public Punkt(double x, double y){
        this.x = x;
        this.y = y;
    }

    @Override
    public boolean equals(Object obj){
        if (this == obj){
            return true;
        }
        if (obj == null || obj.getClass() != getClass()){
            return false;
        }
        else{
            Punkt inny = (Punkt) obj;
            return inny.x == this.x && inny.y == this.y;
        }
    }

    public Punkt przesun(Wektor w){
        double x = this.x + w.dx;
        double y = this.y + w.dy;
        return new Punkt(x, y);
    }

    public Punkt obroc(Punkt p, double kat){
        double radiany = Math.toRadians(kat);

        double this_x_moved = this.x - p.x;
        double this_y_moved = this.y - p.y;

        double x_rotated = this_x_moved * Math.cos(radiany) - this_y_moved * Math.sin(radiany);
        double y_rotated = this_x_moved * Math.sin(radiany) + this_y_moved * Math.cos(radiany);

        double x_final = x_rotated + p.x;
        double y_final = y_rotated + p.y;

        return new Punkt(x_final, y_final);
    }

    public Punkt odbij(Prosta p){
        double n = Math.sqrt(p.a * p.a + p.b * p.b);
        double d = Math.abs(p.a * this.x + p.b * this.y + p.c) / n;

        double dx = p.a / n;
        double dy = p.b / n;

        //ruszamy 2 razy w kierunku znormalizowanego wektora [a, b]
        double x_sym = this.x - 2 * d * dx;
        double y_sym = this.y - 2 * d * dy;

        return new Punkt(x_sym, y_sym);
    }

    @Override
    public String toString() {
        return "(" + x + ", " + y + ")";
    }
}
