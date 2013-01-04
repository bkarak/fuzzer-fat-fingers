import java.io.BufferedReader;
import java.io.InputStreamReader;
 
public class InputText {
    public static void main(String[] args) throws Exception {
        BufferedReader sysin = new BufferedReader(new InputStreamReader(System.in));
        int number = Integer.parseInt(sysin.readLine());
        String string = sysin.readLine();
    }
}