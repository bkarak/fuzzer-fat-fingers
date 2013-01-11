import Data.List
import Control.Monad
import Control.Arrow
 
deficientPermsList =
  ["ABCD","CABD","ACDB","DACB",
  "BCDA","ACBD","ADCB","CDAB",
  "DABC","BCAD","CADB","CDBA",
  "CBAD","ABDC","ADBC","BDCA",
  "DCBA","BACD","BADC","BDAC",
  "CBDA","DBCA","DCAB"]
 
missingPerm :: (Eq a) => [[a]] -> [[a]]
missingPerm = (\\) =<< permutations . nub. join