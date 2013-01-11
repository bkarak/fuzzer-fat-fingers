module sorts_with_custom_comparator
  implicit none
contains
  subroutine a_sort(a, cc)
    character(len=*), dimension(:), intent(inout) :: a
    interface
       integer function cc(a, b)
         character(len=*), intent(in) :: a, b
       end function cc
    end interface
 
    integer :: i, j, increment
    character(len=max(len(a), 10)) :: temp
 
    increment = size(a) / 2
    do while ( increment > 0 )
       do i = increment+1, size(a)
          j = i
          temp = a(i)
          do while ( j >= increment+1 .and. cc(a(j-increment), temp) > 0)
             a(j) = a(j-increment)
             j = j - increment
          end do
          a(j) = temp
       end do
       if ( increment == 2 ) then
          increment = 1
       else
          increment = increment * 5 / 11
       end if
    end do
  end subroutine a_sort
end module sorts_with_custom_comparator

module comparators
  implicit none
contains
  integer function my_compare(a, b)
    character(len=*), intent(in) :: a, b
 
    character(len=max(len(a),len(b))) :: a1, b1
 
    a1 = a
    b1 = b
    call to_lower(b1)
    call to_lower(a1)
 
    if ( len(trim(a)) > len(trim(b)) ) then
       my_compare = -1
    elseif ( len(trim(a)) == len(trim(b)) ) then
       if ( a1 > b1 ) then
          my_compare = 1
       else
          my_compare = -1
       end if
    else
       my_compare = 1
    end if
  end function my_compare
end module comparators

program CustomComparator
  use comparators
  use sorts_with_custom_comparator
  implicit none
 
  character(len=100), dimension(8) :: str
  integer :: i
 
  str = (/ "this", "is", "an", "array", "of", "strings", "to", "sort" /)
  call a_sort(str, my_compare)
 
  do i = 1, size(str)
     print *, trim(str(i))
  end do
end program CustomComparator