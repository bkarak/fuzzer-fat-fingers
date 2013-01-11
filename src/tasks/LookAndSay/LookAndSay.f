module LookAndSay
  implicit none
 
contains
 
  subroutine look_and_say(in, out)
    character(len=*), intent(in) :: in
    character(len=*), intent(out) :: out
 
    integer :: i, c
    character(len=1) :: x
    character(len=2) :: d
 
    out = ""
    c = 1
    x = in(1:1)
    do i = 2, len(trim(in))
       if ( x == in(i:i) ) then
          c = c + 1
       else
          write(d, "(I2)") c
          out = trim(out) // trim(adjustl(d)) // trim(x)
          c = 1
          x = in(i:i)
       end if
    end do
    write(d, "(I2)") c
    out = trim(out) // trim(adjustl(d)) // trim(x)
  end subroutine look_and_say
 
end module LookAndSay

program LookAndSayTest
  use LookAndSay
  implicit none
 
  integer :: i
  character(len=200) :: t, r
  t = "1"
  print *,trim(t)
  call look_and_say(t, r)
  print *, trim(r)
  do i = 1, 10
     call look_and_say(r, t)
     r = t
     print *, trim(r)
  end do
 
end program LookAndSayTest