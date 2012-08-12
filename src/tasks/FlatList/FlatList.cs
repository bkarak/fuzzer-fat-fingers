using System;
using System.Collections;
 
namespace RosettaCodeTasks
{
	public class FlattenList
	{
		// public static ArrayList Flatten(this ArrayList List)
		// {
			// ArrayList NewList = new ArrayList ( );
 
			// NewList.AddRange ( List );
 
			// while ( NewList.OfType<ArrayList> ( ).Count ( ) > 0 )
			// {
				// int index = NewList.IndexOf ( NewList.OfType<ArrayList> ( ).ElementAt ( 0 ) );
				// ArrayList Temp = (ArrayList)NewList[index];
				// NewList.RemoveAt ( index );
				// NewList.InsertRange ( index, Temp );
			// }
 
			// return NewList;
		// }
		
		//more generic flattener for enumerables
		public static IEnumerable Flatten(IEnumerable enumerable)
		{
			foreach (object element in enumerable)
			{
				IEnumerable candidate = element as IEnumerable;
				if (candidate != null)
				{
					foreach (object nested in Flatten(candidate))
					{
						yield return nested;
					}
				}
				else
				{
					yield return element;
				}
			}
		}
	}

	class Program
	{
	
		static void Main ( string[ ] args )
		{
 
			ArrayList Parent = new ArrayList ( );
			Parent.Add ( new ArrayList ( ) );
			((ArrayList)Parent[0]).Add ( 1 );
			Parent.Add ( 2 );
			Parent.Add ( new ArrayList ( ) );
			( (ArrayList)Parent[2] ).Add ( new ArrayList ( ) );
			( (ArrayList)( (ArrayList)Parent[2] )[0] ).Add ( 3 );
			( (ArrayList)( (ArrayList)Parent[2] )[0] ).Add ( 4 );
			( (ArrayList)Parent[2] ).Add ( 5 );
			Parent.Add ( new ArrayList ( ) );
			( (ArrayList)Parent[3] ).Add ( new ArrayList ( ) );
			( (ArrayList)( (ArrayList)Parent[3] )[0] ).Add ( new ArrayList ( ) );
			Parent.Add ( new ArrayList ( ) );
			( (ArrayList)Parent[4] ).Add ( new ArrayList ( ) );
			( (ArrayList)( (ArrayList)Parent[4] )[0] ).Add ( new ArrayList ( ) );
 
			( (ArrayList)( (ArrayList)( (ArrayList)( (ArrayList)Parent[4] )[0] )[0] ) ).Add ( 6 );
			Parent.Add ( 7 );
			Parent.Add ( 8 );
			Parent.Add ( new ArrayList ( ) );
 
 
			foreach ( Object o in FlattenList.Flatten ( Parent ) )
			{
				Console.WriteLine ( o.ToString ( ) );
			}
		}
 
	}
}