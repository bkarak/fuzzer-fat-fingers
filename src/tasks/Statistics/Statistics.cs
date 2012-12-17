/*
* Basic statistical measurements
*includes:
*
*
* min, max range
* 1st, 2rd Quartile
* Median
* Arithmetic mean
* standard deviation
* z-test implementation to find outliers
*/

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Collections;

namespace statistics
{
    class Program 
    {
        private static void Main()
        {
            string F = "data.txt";
            List<int> list = new List<int>();
            try
            {
                foreach (string readLine in File.ReadLines(F))
                {
                    list.Add(Convert.ToInt32(readLine));
                }
            }
            catch (Exception exception)
                {
                    Console.WriteLine(exception.Message);
                    Environment.Exit(1);
                }

            var l = list.OrderBy(r => r);
            list = l.ToList();
            double Mean = list.Average();
            int MinValue = list.Min();
            int MaxValue = list.Max();
            int Range = MaxValue - MinValue;
            decimal median = GetMedian(list);
            double SD = Sd(list);
            List<int> Z_test = Z_Test(list);
            decimal[] quartiles = null;
			    try{
				quartiles = Quartiles(list);
				   }
			    catch (Exception e)
                   {
				    Console.WriteLine(e);
				   }

                Console.WriteLine(" The elements of this file are sorted and presented: ");
            foreach (var x in list)
            {
                Console.WriteLine(x.ToString());
            }
            Console.WriteLine("\n Our program demonstrates the following calculations: Min, Max, Mean, Range, Median\n Standard Deviation and Quartiles (1st and 3nd):\n");
            Console.WriteLine("\n Minimum number is {0} while Maximum is {1}: ",MinValue, MaxValue + "\n Mean of the numbers is: " + Mean );
            Console.WriteLine(" The Range of values is: " + Range + "\n The Median is: " + median);
            Console.WriteLine(" Standard deviation is: " + SD +"\n");
            Console.WriteLine(" We calculate the outliers through Z-test: ");
            foreach (int item in Z_test)
            {
                Console.WriteLine(item);   
            }
            Console.WriteLine("\n The Quartiles are:\n (1st) Lowerhalh " + quartiles[0] +" (3nd) Upperhalf "+ quartiles[2] /* [1] is median which has been already calculated*/);
            Console.ReadKey();
        }

// Method GetMedian calculates the Median of the number

        public static decimal GetMedian(List<int> list)
        {
            // Create a copy of the input, and sort the copy
            int[] temp = list.ToArray();
            Array.Sort(temp);

            int count = temp.Length;
            if (count == 0)
            {
                throw new InvalidOperationException("Empty collection");
            }
            else if (count % 2 == 0)
            {
                // count is even, average two middle elements
                int a = temp[count / 2 - 1];
                int b = temp[count / 2];
                return (a + b) / 2m;
            }
            else
            {
                // count is odd, return the middle element
                return temp[count / 2];
            }
        }

// Sd method calculated standard deviation

        public static double Sd(List<int> list)
        {

        	double sum = 0;

        	double mean = list.Average();

        for (int i = 0; i < list.Count; i++)

            sum += Math.Pow((i - mean), 2);

        return Math.Sqrt( sum / ( list.Count - 1 ) ); // sample
 	   }

// z-test implementation

	    public static List<int> Z_Test (List<int> list)
	    {	
            List<int> result = new List<int>();
            double mean = list.Average();
            double sd = Sd(list);
            foreach (int elem in list){
                if ((Math.Abs((elem) - mean) / sd) > 3)
                    result.Add(elem);
            }
            return result;
	    }


// Quartiles method calculates quartiles. get an arraylist and returns an array with the lowerhalf , the upperhalf and the median

		public static decimal[] Quartiles(List<int> list) 
		{
			if (list.Count < 3)
    		throw new Exception("Because your file has less than 3 elements the Quartiles calculation cannot take place.");

		    decimal qmedian = GetMedian(list);

		    List<int> lowerHalf = GetValuesLessThan(list, qmedian, true);
		    List<int> upperHalf = GetValuesGreaterThan(list, qmedian, true);

		    return new decimal[] {GetMedian(lowerHalf), qmedian, GetMedian(upperHalf)};
		}

// GetValuesGreaterThan creates an arraylist which consists the values of the list that are greater than the median

		public static List<int> GetValuesGreaterThan(List<int> list, decimal limit, bool orEqualTo)
		{
		    List<int> modValues = new List<int>();

            foreach (int item in list)
            {
                if (((decimal)item > limit) || (item == limit && orEqualTo))
                    modValues.Add(item);
            }
		return modValues;
		}


// GetValuesLessThan creates an arraylist which consists the values of the list that are lower than the median
		
        public static List<int> GetValuesLessThan(List<int> list, decimal limit, bool orEqualTo)
		{
		    List<int> modValues = new List<int>();

            foreach (int item in list)
            {
                if (((decimal)item < limit) || (item == limit && orEqualTo))
                    modValues.Add(item);
            }
            return modValues;
		}
		
    }
}
       

