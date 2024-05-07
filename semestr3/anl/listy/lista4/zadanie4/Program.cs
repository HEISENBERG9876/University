double f(double x)
{
    return Math.Pow(x, 4) - Math.Log(x + 4);
}

double bisekcja(double a, double b, double n, Func<double, double> f)
{
    if (n == 0)
    {
        return (a + b) / 2d;
    }
    else
    {
        double x3 = (a + b) / 2d;
        double fa = f(a);
        double fb = f(b);
        double fx3 = f(x3);

        if (fx3 * fa < 0)
        {
            return bisekcja(a, x3, n - 1, f);
        }
        else if (fx3 * fb < 0)
        {
            return bisekcja(x3, b, n - 1, f);
        }
        else if (fx3 == 0)
            return x3;
        else
        {
            return double.NaN;
        }
    


    }
}
Console.WriteLine("x1 = " + bisekcja(0, 2d, 26d, f));
Console.WriteLine("x2 = " + bisekcja(-2d, 0, 26d, f));