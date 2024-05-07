package obliczenia;

public abstract class Dzialanie extends Wyrazenie {
    protected Wyrazenie arg1;
    public Dzialanie(Wyrazenie arg1){
        this.arg1 = arg1;
    }
    public abstract double oblicz();
}
