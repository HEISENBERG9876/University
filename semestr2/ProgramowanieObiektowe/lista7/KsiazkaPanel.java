import java.awt.*;
import javax.swing.*;

public class KsiazkaPanel extends JPanel{
    private JPanel buttonPanel, textPanel, labelPanel;
    private JButton zapiszButton, wyjdzButton;

    KsiazkaPanel(Ksiazka ksiazka){

        textPanel = new JPanel(new GridLayout(1, 3));
        labelPanel = new JPanel(new GridLayout(1, 3));
        buttonPanel = new JPanel(new GridLayout(1, 2));

        JLabel tytulLabel = new JLabel("Tytul");
        JLabel autorLabel = new JLabel("Autor");
        JLabel rokWydaniaLabel = new JLabel("Rok wydania");

        labelPanel.add(tytulLabel);
        labelPanel.add(autorLabel);
        labelPanel.add(rokWydaniaLabel);

        TextField autorField = new TextField(ksiazka.getAutor());
        TextField tytulField = new TextField(ksiazka.getTytul());
        TextField rokWydaniaField = new TextField(Integer.toString(ksiazka.getRokWydania()));

        textPanel.add(autorField);
        textPanel.add(tytulField);
        textPanel.add(rokWydaniaField);

        zapiszButton = new JButton("ZAPISZ");
        zapiszButton.addActionListener(e->{
            ksiazka.setAutor(autorField.getText());
            ksiazka.setTytul(tytulField.getText());
            ksiazka.setRokWydania(Integer.parseInt(rokWydaniaField.getText()));
        });

        wyjdzButton = new JButton("WYJDZ");
        wyjdzButton.addActionListener(e->{
            SwingUtilities.getWindowAncestor(this).dispose();
        });

        buttonPanel.add(zapiszButton);
        buttonPanel.add(wyjdzButton);

        setLayout(new BoxLayout(this, BoxLayout.Y_AXIS));
        add(labelPanel);
        add(textPanel);
        add(buttonPanel);
    }
}