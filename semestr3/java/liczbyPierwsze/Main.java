public class Main {
    public static void main(String[] args) {
        if (args.length == 0) {
            System.err.println("Podaj argumenty! UwU");
            return;
        }

        for (String arg : args) {
            long liczba = Long.parseLong(arg);
            System.out.print(liczba + " = ");
            long[] primeFactors = LiczbyPierwsze.naCzynnikiPierwsze(liczba);
            for (int i = 0; i < primeFactors.length; i++) {
                System.out.print(primeFactors[i]);
                if (i < primeFactors.length - 1) {
                    System.out.print(" * ");
                }
            }
            System.out.println();
        }
    }
}