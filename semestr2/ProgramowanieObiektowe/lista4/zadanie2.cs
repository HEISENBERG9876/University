using System.Collections;


public class SlowaFibonacciego : IEnumerable
{
    private int dlugosc;
    private List<string> slowa;

    public SlowaFibonacciego(int dlugosc2){
        dlugosc = dlugosc2;
        slowa = new List<string>();

        for (int licznik = 0; licznik < dlugosc2; licznik++){
            string slowo;

            if (licznik == 0){
                slowo = "b";
            }
            else if (licznik == 1){
                slowo = "a";
            }
            else{
                slowo = slowa[licznik - 1] + slowa[licznik - 2];
            }

            slowa.Add(slowo);
        }
    }

    public IEnumerator GetEnumerator()
    {
        return slowa.GetEnumerator();
    }
}


class Zadanie2
{
    static void Main(string[] args)
    {
        SlowaFibonacciego sf = new SlowaFibonacciego(6);
        foreach(string s in sf){
        Console.WriteLine(s);
        }
    }
}