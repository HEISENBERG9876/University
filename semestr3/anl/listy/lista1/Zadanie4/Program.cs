double y0 = 1d;
double y1 = -1d / 9d;

for(double x = 0d; x <= 48d; x++)
{
    double result = 80d / 9d * y1 + y0;
    y0 = y1;
    y1 = result;
    Console.WriteLine(result);
}