double ae0 = 0.605456053;
double re0 = 0.763907023;

void printRSequence(double re0, int steps)
{
    int oryg_steps = steps;
    while(steps > 0)
    {
        int current_step = oryg_steps - steps;
        steps--;
        Console.WriteLine("Step: " + current_step + " e: " + re0);
        re0 = Math.Pow(re0, 3) * 1.2;
    }
    Console.WriteLine();
}

void printASequence(double ae0, int steps)
{
    int oryg_steps = steps;
    while (steps > 0)
    {
        int current_step = oryg_steps - steps;
        steps--;
        Console.WriteLine("Step: " + current_step + " e: " + ae0);
        ae0 = ae0 * 0.09;
    }
    Console.WriteLine();
}

printRSequence(re0, 10);
printASequence(ae0, 100);

