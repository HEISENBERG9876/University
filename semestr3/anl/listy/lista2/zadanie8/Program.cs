double Factorial(int n)
{
    double result = 1;
    while(n != 0)
    {
        result *= n;
        n -= 1;
    }
    return result;
}

double CosWithMclaurin(double x)
{
    double sum = 0d;
    for (int k = 1; k < 4; k++)
    {
        sum += Math.Pow(-1, k) * Math.Pow(x, 2 * k) / Factorial((int)(2 * k));
    }
    return sum;
}


for (double i = 10d; i < 20d; i++)
{
    double x = Math.Pow(10d, -i);
    double c = CosWithMclaurin(17 * x);
    double num = -c;
    double den = x * x;
    double result = 14d * num / den;
    Console.WriteLine(result);
}