import javax.swing.*;
import java.io.*;

public class Main {
    public static void main(String[] args) {
        Ksiazka ksiazka = new Ksiazka("Jakas ksiazka", "jakis autor", 1212);
        Czasopismo czasopismo = new Czasopismo("Jakies czasopismo", "jakis autor", 2015, "Miesiecznik");
        WydawnictwoCiagle wydawnictwo = new WydawnictwoCiagle("Jakies wydawnictwo", "jakis autor", 2015, 100);
        new Menu(ksiazka, czasopismo, wydawnictwo);
    }
}
