


Console.WriteLine("double");
for (double i = 10d; i < 20d; i++)
{
    double x = Math.Pow(10d, -i);
    double c = Math.Cos(17d * x);
    double num = 1d - c;
    double den = x * x;
    double result = 14d * num / den;
    Console.WriteLine(result);
}

Console.WriteLine("float");
for (float i = 10f; i < 20f; i++)
{
    float x = MathF.Pow(10f, -i);
    float c = MathF.Cos(17f * x);
    float num = 1f - c;
    float den = x * x;
    float result = 14f * num / den;
    Console.WriteLine(result);
}

