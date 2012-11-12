import Data.Char
 
main = do
  print (ord 'a') -- prints "97"
  print (chr 97) -- prints "'a'"
  print (ord 'ð') -- prints "960"
  print (chr 960) -- prints "'\960'"