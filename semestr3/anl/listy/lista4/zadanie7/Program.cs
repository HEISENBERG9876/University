double GetNewtonInverseSqrt(double xn, double m, double c, int steps)
{
    double xnplus1 = (xn / 2) + (m / (2 * xn));
    while (steps > 0)
    {
        xn = xnplus1;
        xnplus1 = (xn / 2) + (m / (2 * xn));
        steps--;
    }
    return xnplus1 * Math.Pow(2, c / 2);
}

void test(double m, double c)
{
    double a = m * Math.Pow(2, c);
    double[] x1list = { 0.08d, 0.09d, 0.1d, 0.11d, 0.12d, 0.28d, 0.3d, 0.31d, 0.32d, 0.33d, 0.4d, 0.5d, 0.6d, 0.61d, 0.7d, 0.8d, 1.0d, 1.5d, 2d, 4d, 10d };
    Console.WriteLine($"a = {a}, oczekiwana wartość = {Math.Sqrt(a)}");

    for (int i = 0; i < x1list.Length; i++)
    {
        double x = GetNewtonInverseSqrt(x1list[i], m, c, 100);
        Console.WriteLine($"x0 = {x1list[i]}, rzeczywista wartosc = {x}");
    }
    Console.WriteLine();
}


test(4, 2);
test(10, 1);
test(100, 1);