using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;

namespace Substring
{
    public class Substring
    {
        public static void Main(string[] args)
        {
            Console.WriteLine(CountSubStrings("the three truths", "th"));
        }
        
        public static int CountSubStrings(string testString, string testSubstring)
		{
        int location = 0;
        int count = 0;
        while (location < testString.Length)
        {
            int found = testString.IndexOf(testSubstring, location);
            if (found == -1)
            {
                break;
            }
            else
            {
                count++;
                location = location + testSubstring.Length;
            }
        }
        return count;
		}
    }
}
