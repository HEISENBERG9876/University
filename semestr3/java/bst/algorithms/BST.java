package algorithms;

public class BST<T extends Comparable<T>> implements Dictionary<T>{
    public class Node {
        public Node left;
        public Node right;
        public T value;

        Node(T value) {
            this.value = value;
            this.left = this.right = null;
        }
    }

    public Node root;

    public BST() {
        this.root = null;
    }

    @Override
    public boolean search(T x) {
        return search(root, x);
    }

    private boolean search(Node root, T x) {
        if (root == null) {
            return false;
        }

        int compareResult = x.compareTo(root.value);

        if (compareResult < 0) {
            return search(root.left, x);
        } else if (compareResult > 0) {
            return search(root.right, x);
        } else {
            return true;
        }
    }

    @Override
    public void insert(T x) {
        if (x == null) {
            throw new IllegalArgumentException("Cannot insert null value into the BST.");
        }

        root = insert(root, x);
    }

    private Node insert(Node root, T x) {
        if (root == null) {
            return new Node(x);
        }

        int compareResult = x.compareTo(root.value);

        if (compareResult < 0) {
            root.left = insert(root.left, x);
        } else if (compareResult > 0) {
            root.right = insert(root.right, x);
        }

        return root;
    }

    @Override
    public void remove(T x) {
        root = remove(root, x);
    }

    private Node remove(Node root, T x) {
        if (root == null) {
            return null;
        }

        int compareResult = x.compareTo(root.value);
        if (compareResult < 0) {
            root.left = remove(root.left, x);
        } else if (compareResult > 0) {
            root.right = remove(root.right, x);
        } else {
            if (root.left == null) {
                return root.right;
            } else if (root.right == null) {
                return root.left;
            }

            root.value = minValue(root.right);
            root.right = remove(root.right, root.value);
        }

        return root;
    }

    private T minValue(Node root) {
        T minValue = root.value;
        while (root.left != null) {
            minValue = root.left.value;
            root = root.left;
        }
        return minValue;
    }

    @Override
    public T min() {
        if (root == null) {
            throw new IllegalStateException("Cannot find minimum value in an empty BST.");
        }
        return minValue(root);
    }

    @Override
    public T max() {
        if (root == null) {
            throw new IllegalStateException("Cannot find maximum value in an empty BST.");
        }
        return maxValue(root);
    }

    private T maxValue(Node root) {
        T maxValue = root.value;
        while (root.right != null) {
            maxValue = root.right.value;
            root = root.right;
        }
        return maxValue;
    }

    public int size() {
        return size(root);
    }

    private int size(Node root) {
        if (root == null) {
            return 0;
        }
        return 1 + size(root.left) + size(root.right);
    }

    public void clear() {
        root = null;
    }
}
