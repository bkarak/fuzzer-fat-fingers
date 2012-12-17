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

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Scanner;
import java.util.Arrays;


public class Statistics {

	public static void main(String[] args) {
		Scanner file = null;
		ArrayList<Double> list = new ArrayList<Double>();

		try {
			file = new Scanner(new File("data.txt"));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}

		while(file.hasNext()){
			if (file.hasNextDouble()) list.add(file.nextDouble());
			else file.next();
		}

		// sort arraylist
		Collections.sort(list);

		double minValue = getMinValue(list);
		double maxValue = getMaxValue(list);
		double mean = Mean(list);
		double range = maxValue - minValue;
		double median = Median(list);
		double sd = Sd(list);
		ArrayList z_test = Z_Test(list);

		double[] quartiles = null;
			 try{
				quartiles = Quartiles(list);
				}
			catch (Exception e){
				System.out.println(e.getMessage());
				}
		System.out.println("\nThe elements of this file are sorted and presented: \n");
		for (Double i: list) System.out.println(i);
		System.out.println("\n Our program demonstrates the following calculations: Min, Max, Mean, Range, Median\n Standard Deviation and Quartiles (1st and 3nd):\n");
		System.out.println(" Minimum number is: " + minValue + " while Maximum is: " + maxValue + " .");
		System.out.println(" Mean is: " + mean + "\n Range is: " + range + "\n Median is: " + median + "\n Standard Deviation is: "+ sd + ".\n");
    	System.out.println(" We calculate Quartiles:\n 1) LoweHalf is: "+quartiles[0] + /*", Median is: " + quartiles[1] + */"\n 2) UpperHalf is: " + quartiles[2] + ".\n");
		System.out.println(" We finally calculate the outliers through z-test, which are: \n");
		for(int i=0; i<z_test.size(); i++)
		System.out.println(z_test.get(i) + "\n");
		}

// Method Median calculates the median(the middle number of the array) of the values

		public static double Median(ArrayList list)
		{

  		  if (list.size() % 2 == 1)
		  	return (double)list.get((list.size()+1)/2-1);
    	  else
    		{
			double lower = (double)(list.get(list.size()/2-1));
			double upper = (double)(list.get(list.size()/2));

			return (lower + upper) / 2.0;
    		}
		}

//method getMaxValue calculates the Max of the values

		public static double getMaxValue(ArrayList list){
		  double maxValue = (double)list.get(0);
		  for(int i=0; i < list.size(); i++){
		    if((double)list.get(i) > maxValue){
		      maxValue = (double)list.get(i);
		    }
		  }
		  return maxValue;
		}

// method getMinValue calculates the Min of the values

		public static double getMinValue(ArrayList list){
		  double minValue = (double)list.get(0);
		  for(int i=0; i<list.size(); i++){
		    if((double)list.get(i) < minValue){
		      minValue = (double)list.get(i);
		    }
		  }
		  return minValue;
		}

// method Mean calculates the average of the values

		public static double Mean(ArrayList list) {
		    double sum = 0;
		    for (int i = 0; i < list.size(); i++) {
		        sum += (double)list.get(i);
		    }
		    return sum / list.size();
		}

// Sd method calculated standard deviation

		public static double Sd (ArrayList list){

        	int sum = 0;

        	double mean = Mean(list);

        for (int i = 0; i < list.size(); i++)

            sum += Math.pow((i - mean), 2);

        return Math.sqrt( sum / ( list.size() - 1 ) ); // sample
 	   }

// z-test implementation

	public static ArrayList<Double> Z_Test (ArrayList list)
	{	ArrayList<Double> result = new ArrayList<Double>();
		double z;
		double mean = Mean(list);
		double sd = Sd(list);
		for (int i = 0; i < list.size(); i++){
			z = (Math.abs((double)(list.get(i))-mean)/sd);
			if (z>3) result.add((double)list.get(i));
			}
			return result;
	}

// Quartiles method calculates quartiles. get an arraylist and returns an array with the lowerhalf , the upperhalf and the median

		public static double[] Quartiles(ArrayList list) throws Exception
		{
			if (list.size() < 3)
    		throw new Exception("Because your file has less than 3 elements the Quartiles calculation cannot take place.");

		    double qmedian = Median(list);

		    ArrayList lowerHalf = GetValuesLessThan(list, qmedian, true);
		    ArrayList upperHalf = GetValuesGreaterThan(list, qmedian, true);

		    return new double[] {Median(lowerHalf), qmedian, Median(upperHalf)};
		}

// GetValuesGreaterThan creates an arraylist which consists the values of the list that are greater than the median

		public static ArrayList GetValuesGreaterThan(ArrayList list, double limit, boolean orEqualTo)
		{
		    ArrayList<Double> modValues = new ArrayList<Double>();

			    for (int i = 0; i < list.size(); i++) {
		        if ((double)list.get(i) > limit || ((double)list.get(i) == limit && orEqualTo))
		            modValues.add((double)list.get(i));
		}
		return modValues;
		}


// GetValuesLessThan creates an arraylist which consists the values of the list that are lower than the median
		public static ArrayList GetValuesLessThan(ArrayList list, double limit, boolean orEqualTo)
		{
		    ArrayList<Double> modValues = new ArrayList<Double>();

		    for (int i = 0; i < list.size(); i++) {
		        if ((double)list.get(i) < limit || ((double)list.get(i) == limit && orEqualTo))
		            modValues.add((double)list.get(i));
		}
		return modValues;
		}
}