require 'set'
 
def happy?(n)
  seen = Set[]
  state = while n>1 and not seen.include?(n)
    if    $happy_cache[:happy].include?(n): break :happy
    elsif $happy_cache[:sad].include?(n):   break :sad
    end 
    seen << n
    n = sum_of_squares_of_digits(n)
  end
  state.nil? and state = n == 1 ? :happy : :sad
  $happy_cache[state] += seen
  state == :happy 
end
 
def sum_of_squares_of_digits(n)
  n.to_s.each_char.inject(0) {|sum,c| sum += (c.to_i)**2} 
end
 
$happy_cache = Hash.new(Set[])
happy_numbers = []
i = 1
while happy_numbers.length < 8
  happy_numbers << i if happy? i
  i += 1
end
p happy_numbers
p $happy_cache