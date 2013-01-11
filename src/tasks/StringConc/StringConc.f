program StringConcatenation
 
integer, parameter          :: maxstringlength = 64
character (*), parameter    :: s = "hello"
character (maxstringlength) :: s1
 
print *,s // " literal"
s1 = s // " literal"
print *,s1
 
end program