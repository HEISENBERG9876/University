import java.awt.*;
import javax.swing.*;


public class WydawnictwoCiaglePanel extends JPanel{
    private JPanel buttonPanel, textPanel, labelPanel;
    private JButton zapiszButton, wyjdzButton;

    WydawnictwoCiaglePanel(WydawnictwoCiagle wydawnictwoCiagle){
        textPanel = new JPanel(new GridLayout(1, 4));
        labelPanel = new JPanel(new GridLayout(1, 4));
        buttonPanel = new JPanel(new GridLayout(1, 2));

        JLabel tytulLabel = new JLabel("Tytul");
        JLabel autorLabel = new JLabel("Autor");
        JLabel rokWydaniaLabel = new JLabel("Rok wydania");
        JLabel nrWydaniaLabel = new JLabel("Numer wydania");

        labelPanel.add(tytulLabel);
        labelPanel.add(autorLabel);
        labelPanel.add(rokWydaniaLabel);
        labelPanel.add(nrWydaniaLabel);

        TextField autorField = new TextField(wydawnictwoCiagle.getAutor());
        TextField tytulField = new TextField(wydawnictwoCiagle.getTytul());
        TextField rokWydaniaField = new TextField(Integer.toString(wydawnictwoCiagle.getRokWydania()));
        TextField nrWydaniaField = new TextField(Integer.toString(wydawnictwoCiagle.getNrWydania()));

        textPanel.add(autorField);
        textPanel.add(tytulField);
        textPanel.add(rokWydaniaField);
        textPanel.add(nrWydaniaField);

        zapiszButton = new JButton("ZAPISZ");
        zapiszButton.addActionListener(e->{
            wydawnictwoCiagle.setAutor(autorField.getText());
            wydawnictwoCiagle.setTytul(tytulField.getText());
            wydawnictwoCiagle.setRokWydania(Integer.parseInt(rokWydaniaField.getText()));
            wydawnictwoCiagle.setNrWydania(Integer.parseInt(nrWydaniaField.getText()));
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