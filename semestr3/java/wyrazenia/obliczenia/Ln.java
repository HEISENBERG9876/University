package obliczenia;

public class Ln extends Fun1{
    public Ln(Wyrazenie arg1){
        super(arg1);
    }

    @Override
    public double oblicz() {
        return Math.log(arg1.oblicz());
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
            Ln otherLn = (Ln) obj;
            return otherLn.arg1.oblicz() == this.arg1.oblicz();
        }
    }

    @Override
    public String toString(){
        return "Ln(" + arg1.toString() + ")";
    }
}
