package obliczenia;

public class Pot extends Fun2{
    public Pot(Wyrazenie arg1, Wyrazenie arg2){
        super(arg1, arg2);
    }

    @Override
    public double oblicz(){
        return Math.pow(arg1.oblicz(), arg2.oblicz());
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
            Pot otherPot = (Pot) obj;
            return otherPot.oblicz() == this.oblicz();
        }
    }

    @Override
    public String toString(){
        return  "(" + arg1.toString() + ")^(" + arg2.toString() + ")";
    }
}
