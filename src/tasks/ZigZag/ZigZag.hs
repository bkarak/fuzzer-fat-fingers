import Data.Array (array, bounds, range, (!))
import Text.Printf (printf)
import Data.Monoid (mappend)
import Data.List (sortBy)
 
compZig (x,y) (x',y') =           compare (x+y) (x'+y')
                        `mappend` if even (x+y) then compare x x'
                                                else compare y y'
 
zigZag upper = array b $ zip (sortBy compZig (range b))
                             [0..]
  where b = ((0,0),upper)
 
-- format a 2d array of integers neatly
show2d a = unlines [unwords [printf "%3d" (a ! (x,y) :: Integer) | x <- axis fst] | y <- axis snd]
  where (l, h) = bounds a
        axis f = [f l .. f h]
 
main = mapM_ (putStr . show2d . zigZag) [(3,3), (4,4), (10,2)]
