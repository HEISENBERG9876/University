package obliczenia;

public abstract class Oper2 extends Oper1{
    protected Wyrazenie arg2;
    public Oper2(Wyrazenie arg1, Wyrazenie arg2){
        super(arg1);
        this.arg2 = arg2;
    }

    protected String toStringFormatter(Wyrazenie arg1, Wyrazenie arg2, int priorytet, String operator){
        int arg1prio = arg1.getPriorytet();
        int arg2prio = arg2.getPriorytet();
        String arg1str = arg1.toString();
        String arg2str = arg2.toString();

        String arg1wynik = (arg1prio < priorytet) ? "(" + arg1str + ")" : arg1str;
        String arg2wynik = (arg2prio < priorytet) ? "(" + arg2str + ")" : arg2str;

        return arg1wynik + " " + operator + " " + arg2wynik;
    }
}
