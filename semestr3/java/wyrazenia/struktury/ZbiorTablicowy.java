package struktury;

import java.util.Arrays;

public class ZbiorTablicowy implements Zbior, Cloneable{
    private Para[] zbior;
    private final int zapelnienie; //rozmiar tablicy
    private int zapelnioneTeraz = 0;

    public ZbiorTablicowy(int zapelnienie){
        this.zapelnienie = zapelnienie;
        this.zbior = new Para[zapelnienie];
    }

    @Override
    public Para szukaj(String k){
        for(Para para : zbior){
            if(para != null && para.klucz.equals(k)){
                return para;
            }
        }
        return null;
    }

    @Override
    public void wstaw(Para p){
        Para znalezionaPara = szukaj(p.klucz);

        if(znalezionaPara != null){ //znalezlizmy pare w tablicy
            znalezionaPara.setWartosc(p.getWartosc());
        }

        else if(zapelnioneTeraz == zapelnienie) { //zapelniona tablica
            zbior[zapelnioneTeraz - 1] = p;
        }

        else{ //niezapelniona tablica, nieznaleziona para
            zapelnioneTeraz++;
            for(int i = 0; i < zapelnienie; i++){
                if(zbior[i] == null) {
                    zbior[i] = p;
                    break;
                }
            }
        }
    }

    @Override
    public void usun(String k){
        Para paraDoUsuniecia = szukaj(k);
        int indexParyDoUsuniecia = znajdzIndex(paraDoUsuniecia);

        if(indexParyDoUsuniecia != -1){
            zbior[indexParyDoUsuniecia] = null;
            zapelnioneTeraz--;
        }
    }

    @Override
    public void czysc(){
        zapelnioneTeraz = 0;
        for(int i = 0; i < zapelnienie; i++){
            zbior[i] = null;
        }
    }

    @Override
    public int ile(){
        return zapelnioneTeraz;
    }

    private int znajdzIndex(Para para) {
        for (int i = 0; i < zapelnienie; i++) {
            if (zbior[i] != null && zbior[i].equals(para)) {
                return i;
            }
        }
        return -1;
    }

    @Override
    public boolean equals(Object obj){
        if(this == obj){
            return true;
        }

        if(obj == null || obj.getClass() != getClass()){
            return false;
        }
        else {
            ZbiorTablicowy otherZbior = (ZbiorTablicowy) obj;
            return Arrays.equals(this.zbior, otherZbior.zbior);
        }
    }

    @Override
    public String toString() {
        StringBuilder result = new StringBuilder("ZbiorTablicowy{");

        for (int i = 0; i < zapelnienie; i++) {
            if (zbior[i] != null) {
                result.append(zbior[i].toString());
                if (i < zapelnienie - 1) {
                    result.append(", ");
                }
            }
        }

        result.append("}");

        return result.toString();
    }

    @Override
    public ZbiorTablicowy clone() throws CloneNotSupportedException {
        ZbiorTablicowy cloned = (ZbiorTablicowy) super.clone();

        cloned.zbior = new Para[zapelnienie];
        for (int i = 0; i < zapelnienie; i++) {
            if (this.zbior[i] != null) {
                cloned.zbior[i] = this.zbior[i].clone();
            }
        }

        return cloned;
    }


}
