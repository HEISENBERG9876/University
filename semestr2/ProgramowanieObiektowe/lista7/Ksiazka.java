public class Ksiazka{
    private String autor;
    private String tytul;
    private int rokWydania;

    Ksiazka(String autor, String tytul, int rokWydania){
        this.autor = autor;
        this.tytul = tytul;
        this.rokWydania = rokWydania;
    }

    //gettery
    public String getAutor(){
        return autor;
    }
    public String getTytul(){
        return tytul;
    }
    public int getRokWydania(){
        return rokWydania;
    }

    //settery
    public void setAutor(String autor){
        this.autor = autor;
    }
    public void setTytul(String tytul){
        this.tytul = tytul;
    }
    public void setRokWydania(int rokWydania){
        this.rokWydania = rokWydania;
    }
}