import java.util.LinkedList;
import java.util.List;
import java.util.Arrays;
import java.util.ArrayList;
 
public final class FlatList {
 
	public static List<Object> flatten(List<?> list) {
		List<Object> retVal = new LinkedList<Object>();
		flatten(list, retVal);
		return retVal;
	}
 
	public static void flatten(List<?> fromTreeList, List<Object> toFlatList) {
		for (Object item : fromTreeList) {
			if (item instanceof List<?>) {
				flatten((List<?>) item, toFlatList);
			} else {
				System.out.println(item);
			}
		}
	}


	public static void main(String[] args) {
		List<Object> tree = new ArrayList<Object>();
		List<Object> tone = new ArrayList<Object>();
		tone.addAll(Arrays.asList(new Object[] {1, 2, 3})); 
		tree.add(tone);
		List<Object> flat = flatten(tree);

		for (Object o : flat) {
			System.out.println(o);
		}
	}
}