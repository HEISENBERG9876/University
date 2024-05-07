public class WydawnictwoCiagle extends Ksiazka{
    private int nrWydania;

    public WydawnictwoCiagle(String autor, String tytul, int rokWydania, int nrWydania){
        super(autor, tytul, rokWydania);
        this.nrWydania = nrWydania;
    }
    
    public int getNrWydania(){
        return nrWydania;
    }

    public void setNrWydania(int nrWydania){
        this.nrWydania = nrWydania;
    }
}