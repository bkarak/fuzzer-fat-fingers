using System;
using System.Numerics;
 
class Program {
    static void Main() {
        BigInteger pow2_64 = BigInteger.Pow(2, 64);
        BigInteger result = BigInteger.Multiply(pow2_64, pow2_64);
        Console.WriteLine(result);
    }
}