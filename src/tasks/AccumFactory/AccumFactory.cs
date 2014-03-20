using System;

 class AccumFactory {
    private double sum;

     AccumFactory(double sum0) {
        sum = sum0;
    }

     double call(double n) {
        return sum += n;
    }
 
     static void Main(String[] args) {
        AccumFactory x = new AccumFactory(1);
        x.call(5);
        Console.WriteLine(x.call(2.3));
    }
}
