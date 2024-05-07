package prezentacja;

import Rozgrywka.Gra;
import obliczenia.Wymierna;

import java.awt.*;
import java.awt.event.*;
import java.io.IOException;
import java.util.Objects;

import java.util.logging.Logger;
import java.util.logging.Level;
import java.util.logging.LogManager;


public class Okno extends Frame {

    private Gra gra = new Gra();
    private TextField informacjaZwrotaTextField, licznikTextField, mianownikTextField,  iloscProbCounter;
    private Button propozycjaButton, zrestartujButton, rozpocznijGreButton, zakonczButton;
    private Scrollbar zakresScrollbar;

    private static final Logger logger = Logger.getLogger(Okno.class.getName());

    public Okno() {
        super("Zgadywanie");
        setSize(400, 300);
        setLayout(new GridLayout(7, 2));

        informacjaZwrotaTextField = new TextField("Podaj liczbę");
        licznikTextField = new TextField();
        mianownikTextField = new TextField();
        propozycjaButton = new Button("Propozycja");
        zrestartujButton = new Button("Restart");
        rozpocznijGreButton = new Button("Rozpocznij grę");
        zakonczButton = new Button("Zakończ");
        iloscProbCounter = new TextField();
        zakresScrollbar = new Scrollbar(Scrollbar.HORIZONTAL, 5, 1, 5, 20);

        add(new Label("Status:"));
        add(informacjaZwrotaTextField);
        add(new Label("Licznik:"));
        add(licznikTextField);
        add(new Label("Mianownik:"));
        add(mianownikTextField);
        add(new Label("Ilość prób:"));
        add(iloscProbCounter);
        add(new Label("Zakres:"));
        add(zakresScrollbar);
        add(propozycjaButton);
        add(zrestartujButton);
        add(rozpocznijGreButton);
        add(zakonczButton);

        setComponentsEnabledForBeforeTheGameStart(true);

        rozpocznijGreButton.addActionListener(e -> {
            int zakres = zakresScrollbar.getValue();
            gra.start(zakres);

            iloscProbCounter.setText(Integer.toString(gra.getPozostalaIloscProb()));

            setComponentsEnabledForGameInProgress(true);
            logger.log(Level.INFO, "Gra rozpoczeta, zakres: ", zakres);
        });

        zrestartujButton.addActionListener(e -> {
            gra = new Gra();

            licznikTextField.setText("");
            mianownikTextField.setText("");
            informacjaZwrotaTextField.setText("Podaj liczbę");
            iloscProbCounter.setText("");
            zakresScrollbar.setValue(5);

            setComponentsEnabledForBeforeTheGameStart(true);
            logger.log(Level.INFO, "Gra zrestartowana");
        });

        zakonczButton.addActionListener(e -> {
            System.exit(0);
            logger.log(Level.INFO, "Gra zakonczona");
        });

        propozycjaButton.addActionListener(e -> {
            if(gra.getPozostalaIloscProb() == 0){
                informacjaZwrotaTextField.setText("Gra zakończona");
                logger.log(Level.INFO, "Gra zakonczona: 0 pozostalych prob");
                return;
            }
            else if (Objects.equals(licznikTextField.getText(), "") || Objects.equals(mianownikTextField.getText(), "")) {
                informacjaZwrotaTextField.setText("Podaj licznik i mianownik!");
                logger.log(Level.INFO, "Oczekiwanie na propozycje");
                return;
            }

            int licznik = Integer.parseInt(licznikTextField.getText());
            int mianownik = Integer.parseInt(mianownikTextField.getText());

            Wymierna propozycja = new Wymierna(licznik, mianownik);
            gra.odgadnij(propozycja);
            iloscProbCounter.setText(Integer.toString(gra.getPozostalaIloscProb()));

            if (propozycja.compareTo(gra.getWymierna()) < 0) {
                informacjaZwrotaTextField.setText("Zgadywana liczba: " + propozycja + " jest mniejsza od rozwiązania");
                logger.log(Level.INFO, "Podano propozycję " + propozycja + ", jest mniejsza od rozwiazania");
            } else if (propozycja.compareTo(gra.getWymierna()) > 0) {
                informacjaZwrotaTextField.setText("Zgadywana liczba: " + propozycja + " jest większa od rozwiązania");
                logger.log(Level.INFO, "Podano propozycje " + propozycja + ", jest wieksza od rozwiazania");
            } else if (gra.aktualnyStanGry == Gra.STAN_ZWYCIESTWO) {
                informacjaZwrotaTextField.setText("Wygrana, " + propozycja + " to rozwiązanie.");
                propozycjaButton.setEnabled(false);
                logger.log(Level.INFO, "WYGRANA: wygrywająca propozycja to " + propozycja);
            }
        });

        addWindowListener(new WindowAdapter() {
            public void windowClosing(WindowEvent e) {
                logger.log(Level.INFO, "Okno zostało zamknięte.");
                System.exit(0);
            }
        });

        setVisible(true);
    }

    private void setComponentsEnabledForBeforeTheGameStart(boolean toggle) {
        licznikTextField.setEnabled(!toggle);
        mianownikTextField.setEnabled(!toggle);
        propozycjaButton.setEnabled(!toggle);
        zrestartujButton.setEnabled(!toggle);
        rozpocznijGreButton.setEnabled(toggle);
        zakresScrollbar.setEnabled(toggle);
        iloscProbCounter.setEnabled(false);
        informacjaZwrotaTextField.setEnabled(false);
    }

    private void setComponentsEnabledForGameInProgress(boolean toggle) {
        setComponentsEnabledForBeforeTheGameStart(!toggle);
    }

    public static void main(String[] args) {
        try {
            LogManager.getLogManager().readConfiguration(
                    Okno.class.getResourceAsStream("logging.properties")
            );
        } catch (IOException e) {
            System.err.println("Nie udalo sie zaladowac pliku logging.properties");
            e.printStackTrace();
        }

        Thread.setDefaultUncaughtExceptionHandler((thread, throwable) -> {
            logger.log(Level.SEVERE, "Nieznany wyjątek: " + thread.getName(), throwable);
        });

        new Okno();
    }
}
