double f(double x)
{
    return x - 0.49d;
}

void bisekcja(double a, double b, double n, Func<double, double> f)
{
    if (n == 0)
    {
        Console.WriteLine("Krok: " + 5 + " wynik: " + (a + b) / 2d);
        Console.WriteLine("Oszacowanie bledu: " + Math.Pow(2, -6) + " Rzeczywisty blad: " + (0.49 - (a + b) / 2d));
        return;
    }
    else
    {
        double krok = 5d - n;
        double x3 = (a + b) / 2d;
        double fa = f(a);
        double fb = f(b);
        double fx3 = f(x3);

        Console.WriteLine("Krok: " + krok + " wynik: " +  x3);
        Console.WriteLine("Oszacowanie bledu: " + Math.Pow(2, - krok - 1) + " Rzeczywisty blad: " + (0.49 - x3));
        Console.WriteLine();

        if (fx3 * fa < 0)
        {
            bisekcja(a, x3, n - 1d, f);
        }
        else
        {
            bisekcja(x3, b, n - 1d, f);
        }

    }
}
bisekcja(0, 1d, 5d, f);