double x = -(1.5 * Math.Pow(10, 10));

double f(double x)
{
    double a = Math.Pow(x, 3);
    double b = Math.Pow(x, 6);
    double c = 2023 * 2023;
    double i = Math.Sqrt(b + c);
    double d = a + i; /*WYCHODZI 0 :(*/
    double e = 1 / d;
    return e;
}

/*wychodzi NaN, bo dzielimy przez 0*/
/*Console.WriteLine(f(x));*/


double f2(double x)
{
    double a = Math.Pow(x, 12);
    double c = 2023 * 2023;
    double i = Math.Sqrt(a + c);
    double e = i / c;
    return e;
}

Console.WriteLine(f2(x)); /*wychodza duze liczby, co jest bardziej prawdopodobne*/