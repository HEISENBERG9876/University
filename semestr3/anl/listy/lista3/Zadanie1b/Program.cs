double x = 4.000000000000001;
double f(double x)
{
    Console.WriteLine(Math.Log2(x));
    return Math.Log2(x) - 2d;
}


Console.WriteLine(f(x));


/*zapisujemy 2 jako log(2)4*/

double f2(double x)
{
    return Math.Log2(x / 4d);
}

Console.WriteLine(f2(x));