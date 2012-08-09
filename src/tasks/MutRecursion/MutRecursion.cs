namespace RosettaCode {
    class Hofstadter {
        static public int F(int n) {
            int result = 1;
            if (n > 0) {
                result = n - M(F(n-1));
            }
 
            return result;
        }
 
        static public int M(int n) {
            int result = 0;
            if (n > 0) {
                result = n - F(M(n - 1));
            }
 
            return result;
        }

        static void Main ( string[ ] args ) {
            for (int i = 0; i < 20; i++) {
                System.Console.Write(F(i));
            }
            System.Console.WriteLine();
            for (int i = 0; i < 20; i++) {
                System.Console.Write(M(i));
            }
            System.Console.WriteLine();
        }
    }
}