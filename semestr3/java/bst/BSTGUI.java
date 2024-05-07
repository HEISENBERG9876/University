import javax.swing.*;
import java.awt.*;

import algorithms.BST;

public class BSTGUI extends JFrame {
    private BST<Integer> bst;
    private JPanel treePanel;
    private JTextField inputField;
    private JButton insertBtn;
    private JButton removeBtn;

    public static void main(String[] args) {
        SwingUtilities.invokeLater(BSTGUI::new);
    }

    public BSTGUI() {
        bst = new BST<>();
        initializeUI();
    }

    private void initializeUI() {
        setLayout(new FlowLayout());

        treePanel = new TreePanel();
        inputField = new JTextField(5);
        insertBtn = new JButton("Insert");
        removeBtn = new JButton("Remove");

        add(new JLabel("Value:"));
        add(inputField);
        add(insertBtn);
        add(removeBtn);
        add(treePanel);

        inputField.addActionListener(e -> {
            try {
                int inputValue = Integer.parseInt(inputField.getText());
                bst.insert(inputValue);
                treePanel.repaint();
                inputField.setText("");
            } catch (NumberFormatException ex) {
                JOptionPane.showMessageDialog(this, "Invalid input. Please enter a valid integer.");
            }
        });

        insertBtn.addActionListener(e -> {
            try {
                int inputValue = Integer.parseInt(inputField.getText());
                bst.insert(inputValue);
                treePanel.repaint();
                inputField.setText("");
            } catch (NumberFormatException ex) {
                JOptionPane.showMessageDialog(this, "Invalid input. Please enter a valid integer.");
            }
        });

        removeBtn.addActionListener(e -> {
            try {
                int inputValue = Integer.parseInt(inputField.getText());
                bst.remove(inputValue);
                treePanel.repaint();
            } catch (NumberFormatException ex) {
                JOptionPane.showMessageDialog(this, "Invalid input. Please enter a valid integer.");
            }
        });

        pack();
        setVisible(true);

        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    }

    private class TreePanel extends JPanel {
        public TreePanel() {
            Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
            setPreferredSize(screenSize);
        }

        @Override
        protected void paintComponent(Graphics g) {
            super.paintComponent(g);
            drawTree(g, getWidth() / 2, 30, bst.root, 1);
        }

        private void drawTree(Graphics g, int x, int y, BST<Integer>.Node node, int depth) {
            if (node != null) {
                int radius = 30;
                int xOffset = 300 / depth;
                int childY = y + 3 * radius;

                g.setColor(Color.RED);
                g.fillOval(x - radius, y - radius, 2 * radius, 2 * radius);

                g.setColor(Color.BLACK);
                g.drawString(String.valueOf(node.value), x - 5, y + 5);

                if (node.left != null) {
                    drawTree(g, x - xOffset, childY, node.left, depth + 1);
                    g.drawLine(x, y + radius, x - xOffset, childY - radius);
                }

                if (node.right != null) {
                    drawTree(g, x + xOffset, childY, node.right, depth + 1);
                    g.drawLine(x, y + radius, x + xOffset, childY - radius);
                }
            }
        }
    }
}
