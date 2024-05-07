import java.awt.*;
import javax.swing.*;

public class CzasopismoPanel extends JPanel{
    private JPanel buttonPanel, textPanel, labelPanel;
    private JButton zapiszButton, wyjdzButton;

    CzasopismoPanel(Czasopismo czasopismo){
        textPanel = new JPanel(new GridLayout(1, 4));
        labelPanel = new JPanel(new GridLayout(1, 4));
        buttonPanel = new JPanel(new GridLayout(1, 2));

        JLabel tytulLabel = new JLabel("Tytul");
        JLabel autorLabel = new JLabel("Autor");
        JLabel rokWydaniaLabel = new JLabel("Rok wydania");
        JLabel nrWydaniaLabel = new JLabel("Czestotliwosc");

        labelPanel.add(tytulLabel);
        labelPanel.add(autorLabel);
        labelPanel.add(rokWydaniaLabel);
        labelPanel.add(nrWydaniaLabel);

        TextField autorField = new TextField(czasopismo.getAutor());
        TextField tytulField = new TextField(czasopismo.getTytul());
        TextField rokWydaniaField = new TextField(Integer.toString(czasopismo.getRokWydania()));
        TextField czestotliwoscField = new TextField(czasopismo.getCzestotliwosc());

        textPanel.add(autorField);
        textPanel.add(tytulField);
        textPanel.add(rokWydaniaField);
        textPanel.add(czestotliwoscField);

        zapiszButton = new JButton("ZAPISZ");
        zapiszButton.addActionListener(e->{
            czasopismo.setAutor(autorField.getText());
            czasopismo.setTytul(tytulField.getText());
            czasopismo.setRokWydania(Integer.parseInt(rokWydaniaField.getText()));
            czasopismo.setCzestotliwosc(czestotliwoscField.getText());
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

    CzasopismoPanel(Czasopismo czasopismo, String plik){
        this(czasopismo);

        JFrame frame = new JFrame("Czasopismo");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.add(this);
        frame.setVisible(true);
        frame.pack();
    }
}
