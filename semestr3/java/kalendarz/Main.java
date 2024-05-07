import javax.swing.*;

public class Main {
    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> {
            JFrame frame = new JFrame("Kalendarz");
            frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

            CalendarModel model = new CalendarModel();
            CalendarView view = new CalendarView(model);
            CalendarController controller = new CalendarController(model, view);

            frame.getContentPane().add(view.getMainPanel());
            frame.pack();
            frame.setLocationRelativeTo(null);
            frame.setVisible(true);
        });
    }
}