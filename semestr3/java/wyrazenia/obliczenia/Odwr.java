package obliczenia;

public class Odwr extends Oper1{
    public Odwr(Wyrazenie arg1){
        super(arg1);
    }

    @Override
    public double oblicz(){
        return 1 / arg1.oblicz();
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
            Odwr otherOdwr = (Odwr) obj;
            return otherOdwr.arg1.oblicz() == this.arg1.oblicz();
        }
    }

    @Override
    public String toString(){
        return "1/(" + arg1.toString() + ")";
    }
}
