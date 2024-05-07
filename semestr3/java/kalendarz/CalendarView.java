import javax.swing.*;
import java.awt.*;

class CalendarView {

    private CalendarModel model;
    private JTabbedPane tabbedPane;
    private JList<String> monthList;
    private JList<String> prevMonthList;
    private JList<String> nextMonthList;

    public CalendarView(CalendarModel model) {
        this.model = model;
        initComponents();
    }

    public void initComponents() {
        JFrame frame = new JFrame("Kalendarz");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        tabbedPane = new JTabbedPane();
        frame.getContentPane().add(tabbedPane);

        JPanel yearPanel = createYearPanel();
        tabbedPane.addTab("Rok", yearPanel);

        JPanel monthPanel = createMonthPanel();
        tabbedPane.addTab("Miesiąc", monthPanel);
    }

    public JPanel createYearPanel() {
        JPanel yearPanel = new JPanel(new GridLayout(3, 4));

        for (int i = 0; i < 12; i++) {
            JList<String> monthList = new JList<>(model);
            monthList.setCellRenderer(new CalendarCellRenderer());
            JScrollPane scrollPane = new JScrollPane(monthList);
            yearPanel.add(scrollPane);
        }

        return yearPanel;
    }

    public JPanel createMonthPanel() {
        JPanel monthPanel = new JPanel(new BorderLayout());

        monthList = new JList<>(model);
        monthList.setCellRenderer(new CalendarCellRenderer());
        JScrollPane scrollPane = new JScrollPane(monthList);
        monthPanel.add(scrollPane, BorderLayout.CENTER);

        prevMonthList = new JList<>(model);
        prevMonthList.setCellRenderer(new CalendarCellRenderer());
        JScrollPane prevScrollPane = new JScrollPane(prevMonthList);
        monthPanel.add(prevScrollPane, BorderLayout.WEST);

        nextMonthList = new JList<>(model);
        nextMonthList.setCellRenderer(new CalendarCellRenderer());
        JScrollPane nextScrollPane = new JScrollPane(nextMonthList);
        monthPanel.add(nextScrollPane, BorderLayout.EAST);

        return monthPanel;
    }

    public JTabbedPane getMainPanel() {
        return tabbedPane;
    }
}