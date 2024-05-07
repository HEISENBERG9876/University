import javax.swing.*;
import java.awt.*;

class CalendarController {

    private CalendarModel model;
    private CalendarView view;

    public CalendarController(CalendarModel model, CalendarView view) {
        this.model = model;
        this.view = view;
    }
}

class CalendarCellRenderer extends DefaultListCellRenderer {

    @Override
    public Component getListCellRendererComponent(JList<?> list, Object value, int index, boolean isSelected, boolean cellHasFocus) {
        Component renderer = super.getListCellRendererComponent(list, value, index, isSelected, cellHasFocus);

        String dateString = value.toString();
        if (dateString.contains("Sun")) {
            renderer.setForeground(Color.RED);
        } else {
            renderer.setForeground(Color.BLACK);
        }

        return renderer;
    }
}