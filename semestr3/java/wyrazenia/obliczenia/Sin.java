package obliczenia;

public class Sin extends Fun1 {
    public Sin(Wyrazenie arg1){
        super(arg1);
    }

    @Override
    public double oblicz(){
        return Math.sin(arg1.oblicz());
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
            Sin otherSin = (Sin) obj;
            return otherSin.arg1.oblicz() == this.arg1.oblicz();
        }
    }

    @Override
    public String toString(){
        return "Sin(" + arg1.toString() + ")";
    }
}
