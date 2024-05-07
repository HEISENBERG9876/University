/*jeden pierwiastek bedzie nieprawidlowy dla bardzo malego  b, a drugi dla bardzo duzego b gdy ac jest bliskie 0*/
double a = 1;
double big_b = Math.Pow(2, 100);
double small_b = -Math.Pow(2, 100);
double c = Math.Pow(2, -10);
void Roots(double a, double b, double c)
{
    double sqrtdelta = Math.Sqrt(b * b - 4d * a * c);
    double x1 = (-b - sqrtdelta) / (2 * a);
    double x2 = (-b + sqrtdelta) / (2 * a);
    Console.WriteLine("a= " + a + " b= " + b + " c= " + c);
    Console.WriteLine("x1= " + x1);
    Console.WriteLine("x2= " + x2);
    Console.WriteLine();
}

Console.WriteLine("Niepoprawna metoda:");
Roots(a, big_b, c);
Roots(a, small_b, c);

Console.WriteLine();


/*korzystamy z wzorow viete'a*/
void Roots2(double a, double b, double c)
{
    double x1 = 1.0f;
    double x2 = 1.0f;
    double sqrtdelta = Math.Sqrt(b * b - 4d * a * c);
    if (b >= 0)
    {
        x1 = (-b - sqrtdelta) / (2 * a);
        x2 = c / (a * x1);
    }
    else if (b < 0)
    {
        x1 = (-b + sqrtdelta) / (2 * a);
        x2 = c / (a * x1);
    }
    Console.WriteLine("a= " + a + " b= " + b + " c= " + c);
    Console.WriteLine("x1= " + x1);
    Console.WriteLine("x2= " + x2);
    Console.WriteLine();
}

Console.WriteLine("Poprawna metoda:");
Roots2(a, big_b, c);
Roots2(a, small_b, c);

