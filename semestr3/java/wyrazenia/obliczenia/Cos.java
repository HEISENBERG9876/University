package obliczenia;

public class Cos extends Fun1 {
    public Cos(Wyrazenie arg1){
        super(arg1);
    }

    @Override
    public double oblicz(){
        return Math.cos(arg1.oblicz());
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
            Cos otherCos = (Cos) obj;
            return otherCos.arg1.oblicz() == this.arg1.oblicz();
        }
    }

    @Override
    public String toString(){
        return "Cos(" + arg1.toString() + ")";
    }
}
