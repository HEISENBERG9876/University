#nullable disable
using System;

public class IntStream{
    protected int current;
    protected bool max_current = false;
    public virtual int next(){
        if (current + 1 < current){
            max_current = true;
            return current;
        }
        else{
            current += 1;
        return current;
        }
    }
    public bool eos(){
        if(max_current){
            return true;
        }
        else{
            return false;
        }
    }

    public virtual void reset(){
        current = 0;
    }
    

}

public class PrimeStream : IntStream{
    private int counter = 0;
    private bool is_prime(int n){
        for(int x = 2; x < n; x++){
            if (n % x == 0){
                return false;
            }
        }
        return true;
    }

    private int nth_prime(int n){
        int counter = 0;
        int current_number = 2;
        while(counter < n){
            if (is_prime(current_number)){
                counter += 1;
                current_number += 1;
            }
            else{
                current_number += 1;
            }
        }
        return current_number - 1;
        }


    public override int next(){
        if (nth_prime(counter + 1) < current){
            max_current = true;
            return current;
        }
        else{
            current = nth_prime(counter + 1);
            counter += 1;
        return current;
        }
    }
    public override void reset(){
        counter = 0;
        current = 0;
    }
    

}

public class RandomStream : PrimeStream{

    public override int next(){
        var rand = new Random();
        int num = rand.Next();
        return num;
        }
    }


class Zadanie1 {
    static void Main(){
        var strumyk = new IntStream();
        var strumykprime = new PrimeStream();
        var strumykrand = new RandomStream();

        //IntStream testy
        Console.WriteLine("IntStream testy");
        Console.WriteLine(strumyk.next());
        Console.WriteLine(strumyk.next());
        Console.WriteLine(strumyk.next());
        Console.WriteLine(strumyk.next());
        Console.WriteLine(strumyk.next());
        strumyk.reset();
        Console.WriteLine(strumyk.next());
        Console.WriteLine(strumyk.next());
        Console.WriteLine(strumyk.next());
        Console.WriteLine(strumyk.next());


        //PrimeStream testy
        Console.WriteLine("PrimeStream testy");
        Console.WriteLine(strumykprime.next());
        Console.WriteLine(strumykprime.next());
        Console.WriteLine(strumykprime.next());
        Console.WriteLine(strumykprime.next());
        Console.WriteLine(strumykprime.next());
        Console.WriteLine(strumykprime.next());
        strumykprime.reset();
        Console.WriteLine(strumykprime.next());
        Console.WriteLine(strumykprime.next());
        Console.WriteLine(strumykprime.next());
        Console.WriteLine(strumykprime.next());
        Console.WriteLine(strumykprime.next());
        Console.WriteLine(strumykprime.next());


        //RandomStream testy
        Console.WriteLine("RandomStream testy");
        Console.WriteLine(strumykrand.next());
        Console.WriteLine(strumykrand.next());
        Console.WriteLine(strumykrand.next());
        Console.WriteLine(strumykrand.next());
        Console.WriteLine(strumykrand.next());
        Console.WriteLine(strumykrand.next());
        strumykrand.reset();
        Console.WriteLine(strumykrand.next());
        Console.WriteLine(strumykrand.next());
        Console.WriteLine(strumykrand.next());
        Console.WriteLine(strumykrand.next());
        Console.WriteLine(strumykrand.next());
        
    }
}

