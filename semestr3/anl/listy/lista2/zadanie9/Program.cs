//pierwszy sposob- nie dziala
double xk = 2d;

for (double k = 1; k < 40; k++)
{
    double a = Math.Pow(xk / Math.Pow(2d, k), 2d);
    double b = Math.Sqrt(1d - a);
    double c = 2 * (1d - b);
    double d = Math.Pow(2, k) * Math.Sqrt(c);
    Console.WriteLine(d);
    xk = d;
}

//drugi sposob- dziala
Console.WriteLine("\nSPOSOB NR 2");
xk = 2d;
for (double k = 1; k < 100; k++)
{
    double a = Math.Pow(xk / Math.Pow(2d, k), 2d);
    double b = Math.Sqrt(1d - a);
    double c = 1 + b;
    double d = 2 * Math.Pow(xk, 2d) / c;
    double e = Math.Sqrt(d);
    Console.WriteLine(e);
    xk = e;
}