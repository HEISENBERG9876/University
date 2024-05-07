using System;
using System.Collections;
using System.Collections.Generic;

double I0 = Math.Log(2024d / 2023d);
List<double> wyniki = new List<double>();
wyniki.Add(I0);


Console.WriteLine("CALY CIAG");
Console.WriteLine(I0);
for (double n = 1d; n <= 20d; n++)
{
    double In = (1d / n) - (2023d * I0); /*I0 to In-1*/
    wyniki.Add(In);
    I0 = In;
    Console.WriteLine(In);
}


Console.WriteLine("\nPOZYCJE NIEPARZYSTE");
for (int i = 1; i < wyniki.Count; i += 2)
{
    double element = wyniki[i];
    Console.WriteLine(element);
}


Console.WriteLine("\nPOZYCJE PARZYSTE");
for (int i = 0; i < wyniki.Count; i += 2)
{
    double element = wyniki[i];
    Console.WriteLine(element);
}
