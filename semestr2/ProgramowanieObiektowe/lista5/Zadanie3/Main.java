abstract class MilitaryRank implements Comparable<MilitaryRank> {
    private String name;
    private int rankOrder;

    public MilitaryRank(String name, int rankOrder) {
        this.name = name;
        this.rankOrder = rankOrder;
    }

    public String getName() {
        return name;
    }

    public int getRankOrder() {
        return rankOrder;
    }

    @Override
    public int compareTo(MilitaryRank other) {
        return Integer.compare(getRankOrder(), other.getRankOrder());
    }

    @Override
    public String toString() {
        return getName();
    }
}


class Soldat extends MilitaryRank {
    public Soldat() {
        super("Soldat", 10);
    }
}


class Leutnant extends MilitaryRank {
    public Leutnant() {
        super("Leutnant", 20);
    }
}


class Generalleutnant extends MilitaryRank {
    public Generalleutnant() {
        super("Generalleutnant", 30);
    }
}


class Generalfeldmarschall extends MilitaryRank {
    public Generalfeldmarschall() {
        super("Generalfeldmarschall", 40);
    }
}


class Main {
    public static void main(String[] args) {
        MilitaryRank rank1 = new Soldat();
        MilitaryRank rank2 = new Leutnant();
        MilitaryRank rank3 = new Generalleutnant();
        MilitaryRank rank4 = new Generalfeldmarschall();

        //sprawdzamy czy rangi dzialaja poprawnie
        System.out.println("rank1: " + rank1.getName() + ", rank: " + rank1.getRankOrder()); 
        System.out.println("rank2: " + rank2.getName() + ", rank: " + rank2.getRankOrder()); 
        System.out.println("rank3: " + rank3.getName() + ", rank: " + rank3.getRankOrder()); 
        System.out.println("rank4: " + rank4.getName() + ", rank: " + rank4.getRankOrder()); 

        //sprawdzany czy lista dziala poprawnie
        OrderedList<MilitaryRank> ord1 = new OrderedList<MilitaryRank>();
        ord1.addElement(rank4);
        ord1.addElement(rank2);
        ord1.addElement(rank3);
        ord1.addElement(rank1);
        System.out.println(ord1.toString());
    }
}