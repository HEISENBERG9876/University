package obliczenia;

public class Mnoz extends Oper2{
    public Mnoz(Wyrazenie arg1, Wyrazenie arg2){
        super(arg1, arg2);
    }

    @Override
    protected int getPriorytet(){
        return 15;
    }

    @Override
    public double oblicz(){
        return arg1.oblicz() * arg2.oblicz();
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
            Mnoz otherMnoz = (Mnoz) obj;
            return otherMnoz.oblicz() == this.oblicz();
        }
    }

    @Override
    public String toString() {
        return toStringFormatter(arg1, arg2, getPriorytet(), "*");
    }
}