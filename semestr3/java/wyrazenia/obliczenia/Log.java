package obliczenia;

public class Log extends Fun2{
    public Log(Wyrazenie arg1, Wyrazenie arg2){
        super(arg1, arg2);
    }

    private double logarytmBazyB(double liczbaLogarytmowana, double baza) {
        return Math.log(liczbaLogarytmowana) / Math.log(baza);
    }

    @Override
    public double oblicz(){
        double baza = arg1.oblicz();
        double logarytmowana = arg2.oblicz();
        if(logarytmowana <= 0){
            throw new IllegalArgumentException("Liczba logarytmowana musi byc wieksza od 0");
        }
        if(baza <= 1){
            throw new IllegalArgumentException("Baza logarytmu musi byc wieksza od 1");
        }
        return logarytmBazyB(logarytmowana, baza);
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
            Log otherLog = (Log) obj;
            return otherLog.oblicz() == this.oblicz();
        }
    }

    @Override
    public String toString(){
        return "Log(" + arg1.toString() + ", " + arg2.toString() + ")";
    }
}
