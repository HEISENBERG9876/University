double sum = 0d;

for (double k = 0d; k <= 2000000d; k++)
{
    sum += 4d * Math.Pow(-1d, k) / (2d * k + 1d);
}

Console.WriteLine(sum);