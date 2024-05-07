public class Czasopismo extends Ksiazka{
    private String czestotliwosc; //tygodnik/miesiecznik itp.

    public Czasopismo(String autor, String tytul, int rokWydania, String czestotliwosc){
        super(autor, tytul, rokWydania);
        this.czestotliwosc = czestotliwosc;
    }

    public String getCzestotliwosc(){
        return czestotliwosc;
    }

    public void setCzestotliwosc(String czestotliwosc){
        this.czestotliwosc = czestotliwosc;
    }
}