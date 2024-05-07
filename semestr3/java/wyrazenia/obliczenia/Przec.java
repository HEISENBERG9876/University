package obliczenia;

public class Przec extends Oper1{
    public Przec(Wyrazenie arg1){
        super(arg1);
    }

    @Override
    public double oblicz(){
        return - arg1.oblicz();
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
            Przec otherPrzec = (Przec) obj;
            return otherPrzec.arg1.oblicz() == this.arg1.oblicz();
        }
    }

    @Override
    public String toString(){
        return "-(" + arg1.toString() + ")";
    }
}
