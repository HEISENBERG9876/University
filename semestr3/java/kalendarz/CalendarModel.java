import javax.swing.*;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;


class CalendarModel extends AbstractListModel<String> {

    private int year;
    private int month;

    public CalendarModel() {
        GregorianCalendar today = new GregorianCalendar();
        this.year = today.get(Calendar.YEAR);
        this.month = today.get(Calendar.MONTH);
    }

    public void setYear(int year) {
        this.year = year;
        fireContentsChanged(this, 0, getSize() - 1);
    }

    public void setMonth(int month) {
        this.month = month;
        fireContentsChanged(this, 0, getSize() - 1);
    }

    @Override
    public int getSize() {
        return new GregorianCalendar(year, month + 1, 0).get(Calendar.DAY_OF_MONTH);
    }

    @Override
    public String getElementAt(int index) {
        SimpleDateFormat sdf = new SimpleDateFormat("EEEE, d MMMM");
        GregorianCalendar date = new GregorianCalendar(year, month, index + 1);
        String dayOfWeek = sdf.format(date.getTime());

        return dayOfWeek;
    }
}