haystack = %w(Zig Zag Wally Ronald Bush Krusty Charlie Bush Bozo)
 
%w(Bush Washington).each do |needle|
  if (i = haystack.index(needle))
    print i, " ", needle, "\n"
  else
    raise "#{needle} is not in haystack\n"
  end
end