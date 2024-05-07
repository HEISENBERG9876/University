package obliczenia;

public abstract class Fun2 extends Fun1{
    protected Wyrazenie arg2;
    public Fun2(Wyrazenie arg1, Wyrazenie arg2){
        super(arg1);
        this.arg2 = arg2;
    }
}
