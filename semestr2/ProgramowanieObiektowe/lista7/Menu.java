import java.awt.*;
import javax.swing.*;

public class Menu extends JPanel {

    private JPanel cardPanel, buttonPanel;
    private JButton ksiazkiButton, czasopismaButton, wydawnictwaButton;
    private CardLayout cardLayout;

    public Menu(Ksiazka ksiazka, Czasopismo czasopismo, WydawnictwoCiagle wydawnictwo) {
        cardPanel = new JPanel();
        cardLayout = new CardLayout();
        cardPanel.setLayout(cardLayout);

        JPanel ksiazkiPanel = new KsiazkaPanel(ksiazka);
        JPanel czasopismaPanel = new CzasopismoPanel(czasopismo);
        JPanel wydawnictwaCiaglePanel = new WydawnictwoCiaglePanel(wydawnictwo);

        cardPanel.add(ksiazkiPanel, "ksiazka");
        cardPanel.add(czasopismaPanel, "czasopismo");
        cardPanel.add(wydawnictwaCiaglePanel, "wydawnictwo");

        buttonPanel = new JPanel(new GridLayout(1, 3));

        ksiazkiButton = new JButton("ksiazka");
        ksiazkiButton.addActionListener(e->{
            cardLayout.show(cardPanel, "ksiazka");
        });

        czasopismaButton = new JButton("czasopismo");
        czasopismaButton.addActionListener(e->{
            cardLayout.show(cardPanel, "czasopismo");
        });

        wydawnictwaButton = new JButton("wydawnictwo");
        wydawnictwaButton.addActionListener(e->{
            cardLayout.show(cardPanel, "wydawnictwo");
        });

        buttonPanel.add(ksiazkiButton);
        buttonPanel.add(czasopismaButton);
        buttonPanel.add(wydawnictwaButton);

        setLayout(new GridLayout(2, 1));
        add(buttonPanel);
        add(cardPanel);

        JFrame frame = new JFrame("Menu");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.add(this);
        frame.setVisible(true);
        frame.pack();
    }
}