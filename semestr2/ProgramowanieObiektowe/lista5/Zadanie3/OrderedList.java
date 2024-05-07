import java.util.ArrayList;
import java.util.Collections;


public class OrderedList<T extends Comparable<T>> {
    private ArrayList<T> list;

    public OrderedList() {
        list = new ArrayList<>();
    }

    public void addElement(T elem) {
        list.add(elem);
        Collections.sort(list);
    }

    public T getFirst() {
        if (list.isEmpty()) {
            return null;
        }
        return list.get(0);
    }

    public String toString() {
        return list.toString();
    }
}