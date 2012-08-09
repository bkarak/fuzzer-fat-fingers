import java.util.StringTokenizer;

public class Tokenizer {
	public static void main(String[] args) {
		String toTokenize = "Hello,How,Are,You,Today";
		StringTokenizer tokenizer = new StringTokenizer(toTokenize, ",");
		
		while(tokenizer.hasMoreTokens()) {
			System.out.print(tokenizer.nextToken() + ".");
		}		
	}
}