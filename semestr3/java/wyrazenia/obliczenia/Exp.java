package obliczenia;

public class Exp extends Fun1{
    public Exp(Wyrazenie arg1){
        super(arg1);
    }
    @Override
    public double oblicz(){
        return Math.pow(arg1.oblicz(), 2);
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
            Exp otherExp = (Exp) obj;
            return otherExp.arg1.oblicz() == this.arg1.oblicz();
        }
    }

    @Override
    public String toString(){
        return "(" + arg1.toString() + ")^2";
    }
}
