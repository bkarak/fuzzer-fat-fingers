public class AccumFactory {
    private double sum;

    public AccumFactory(double sum0) {
        sum = sum0;
    }

    public double call(double n) {
        return sum += n;
    }
 
    public static void main(String[] args) {
        AccumFactory x = new AccumFactory(1);
        x.call(5);
        System.out.println(x.call(2.3));
    }
}