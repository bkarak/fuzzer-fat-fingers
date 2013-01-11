import Data.Char (digitToInt)
luhn = (0 ==) . (`mod` 10) . sum . map (uncurry (+) . (`divMod` 10)) .
       zipWith (*) (cycle [1,2]) . map digitToInt . reverse

map luhn ["49927398716", "49927398717", "1234567812345678", "1234567812345670"]
[True,False,False,True]