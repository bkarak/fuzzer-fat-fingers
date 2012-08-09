using System;

class Tokenizer
{
    static void Main()
    {
        string str = "Hello,How,Are,You,Today"; 
		// or Regex.Split ( "Hello,How,Are,You,Today", "," );
		// (Regex is in System.Text.RegularExpressions namespace
		string[] strings = str.Split(',');
		foreach (string s in strings)
		{
			System.Console.WriteLine (s + ".");
		}
    }
}
