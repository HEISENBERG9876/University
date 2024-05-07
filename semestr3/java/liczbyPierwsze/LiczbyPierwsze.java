public final class LiczbyPierwsze {
    private final static int POTEGA2 = 21;
    private final static int[] SITO = new int[1 << POTEGA2];

    static {
        for (int i = 2; i < SITO.length; i++) {
//          przyrownujemy do zera, zeby przypadkiem nie zamienic na wiekszy dzielnik
            if (SITO[i] == 0) {
                SITO[i] = i;
                for (int j = 2 * i; j < SITO.length; j += i) {
                    if (SITO[j] == 0) {
                        SITO[j] = i;
                    }
                }
            }
        }
    }

    private LiczbyPierwsze() {}

    public static boolean czyPierwsza(long x) {
        if (x < 2) {
            return false;
        }
        //patrzymy, czy najmniejszym podzielnikiem liczby jest ona sama
        else if (x < SITO.length) {
            return SITO[(int) x] == x;
        }
        else {
            for (int i = 2; (long) i * i <= x; i++) {
                if (x % i == 0) {
                    return false;
                }
            }
        }
        return true;
    }

    public static long[] naCzynnikiPierwsze(long x) {
        int maxPrime = (int) Math.sqrt(Math.abs(x)) + 1;
        long[] factors = new long[maxPrime];
        int numOfFactors = 0;

        if (x == 0) {
            return new long[]{0};
        }
        else if (x == 1) {
            return new long[]{1};
        }
        else if (x == -1){
            return new long[]{-1};
        }
        else if (x < 0) {
            x = -x;
            numOfFactors = 1;
            factors[0] = -1;
        }

        while (x > 1) {
            int smallestPrime = SITO[(int) x];
            factors[numOfFactors] = smallestPrime;
            numOfFactors += 1;
            x /= smallestPrime;
        }

        long[] result = new long[numOfFactors];
        System.arraycopy(factors, 0, result, 0, numOfFactors);

        return result;
    }
}