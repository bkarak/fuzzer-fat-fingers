using System.Collections;
using System.Collections.Generic;
using System.Drawing;

public class Power<T> {
  /*public IEnumerable GetPowerSet(List list) {
      return from m in Enumerable.Range(0, 1 << list.Count)
                    select
                        from i in Enumerable.Range(0, list.Count)
                        where (m & (1 << i)) != 0
                        select list[i];
  }*/
  
  private IEnumerable<List<T>> GetPowerSet(List<T> list) {
	for(int m = 0; m < (1 << list.Count); m++) {
		List<T> result = new List<T>();
		for (int i = 0; i < list.Count; i++) {
			if((m & (1 << i)) != 0)
				result.Add(list[i]);
		}
		yield return result;
	}
  }  
   
  private string[] ConvertToString(List<T> input)
  {
	List<string> result = new List<string>();
	foreach(T item in input)
		result.Add(item.ToString());
	return result.ToArray();
  }
   
  public void PowerSet(List<T> list)
  {
      IEnumerable<List<T>> result = GetPowerSet(list);
   
	  foreach(List<T> subset in result)
	  {
		System.Console.WriteLine(string.Join(",", ConvertToString(subset)));
	  }
   
      //Console.Write( string.Join( Environment.NewLine, 
      //    result.Select(subset => 
      //        string.Join(",", subset.Select(clr => clr.ToString()).ToArray())).ToArray()));
  }
}

public class PowerMain
{
	public static void Main(string[] args) {
		Power<KnownColor> p = new Power<KnownColor>();
		
		List<KnownColor> colors = new List<KnownColor> { KnownColor.Red, KnownColor.Green, 
          KnownColor.Blue, KnownColor.Yellow };
		p.PowerSet(colors);
	}
}
