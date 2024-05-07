import java.util.Hashtable;

abstract class Expression {
    public abstract int evaluate();
}

class Const extends Expression {
    private int value;

    public Const(int value) {
        this.value = value;
    }

    public int evaluate() {
        return value;
    }


    public String toString() {
        return Integer.toString(value);
    }
}




class Variable extends Expression {
    String name;

    static Hashtable<String, Integer> variables = new Hashtable<String, Integer>();

    public Variable(String name)
    {
        this.name = name;
    }

    public int evaluate(){
        return variables.get(name);
    }

    public String toString()
    {
        return this.name;
    }
}



abstract class Operator extends Expression {
    protected Expression left;
    protected Expression right;

    public Operator(Expression left, Expression right) {
        this.left = left;
        this.right = right;
    }
}

class Addition extends Operator {
    public Addition(Expression left, Expression right) {
        super(left, right);
    }

    public int evaluate() {
        return left.evaluate() + right.evaluate();
    }

    public String toString() {
        return "(" + left.toString() + " + " + right.toString() + ")";
    }
}


class Multiplication extends Operator {
    public Multiplication(Expression left, Expression right) {
        super(left, right);
    }

    public int evaluate() {
        return left.evaluate() * right.evaluate();
    }

    public String toString() {
        return "(" + left.toString() + " * " + right.toString() + ")";
    }
}



public class Main {
    public static void main(String[] args) {
        Expression e1 = new Const(5);
        Expression e2 = new Const(3);
        Expression e3 = new Addition(e1, e2);
        
        System.out.println("e1 = " + e1 + ", evaluate = " + e1.evaluate());
        System.out.println("e2 = " + e2 + ", evaluate = " + e2.evaluate());
        System.out.println("e3 = " + e3 + ", evaluate = " + e3.evaluate());

        Expression e4 = new Const(10);
        System.out.println(e4);

        Hashtable<String, Integer> variables = new Hashtable<String, Integer>();
        variables.put("x", 4);
        variables.put("z", 7);
        variables.put("y", 5);
        Variable.variables = variables;

        System.out.println("x = " + variables.get("x"));
        System.out.println("y = " + variables.get("y"));
        System.out.println("z = " + variables.get("z"));


        Expression e5 = new Variable("x");
        System.out.println("e5 = " + e5 + ", evaluate = " + e5.evaluate());
        
    }
}