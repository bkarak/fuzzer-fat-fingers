using System.Collections;
using System.Collections.Generic;
using System.Linq;

public class Power {
  public IEnumerable GetPowerSet(List list) {
      return from m in Enumerable.Range(0, 1 << list.Count)
                    select
                        from i in Enumerable.Range(0, list.Count)
                        where (m & (1 << i)) != 0
                        select list[i];
  }
   
  public void PowerSetofColors()
  {
      var colors = new List<KnownColor> { KnownColor.Red, KnownColor.Green, 
          KnownColor.Blue, KnownColor.Yellow };
   
      var result = GetPowerSet(colors);
   
      Console.Write( string.Join( Environment.NewLine, 
          result.Select(subset => 
              string.Join(",", subset.Select(clr => clr.ToString()).ToArray())).ToArray()));
  }

	static void main(string[] args) {
		PowerSetofColors();
	}
}
