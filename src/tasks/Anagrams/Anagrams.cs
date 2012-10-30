using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
 
namespace Anagram
{
    class Program
    {
        static void Main(string[] args)
        {
            var words = File.ReadAllLines("unixdict.txt");
            var groups = from w in words
                         group w by new String(w.ToCharArray().OrderBy(x => x).ToArray()) into c
                         where c.Count() > 1
                         orderby c.Count() descending
                         select c;
            groups.ToList().ForEach(x => Console.WriteLine(String.Join(",", x.ToArray())));
        }
    }
}