
#
# Basic statistical measurements
# includes:
#
#
# * min, max range
# * 1st, 2rd Quartile
# * Median
# * Arithmetic mean
# * standard deviation
# * z-test implementation to find outliers
#


# arithmetic max
def stat_max(contents_array)
	return contents_array.max
	end
	
# arithmetic min
def stat_min(contents_array)
	return contents_array.min
	end
	
# arithmetic range	
def range(contents_array)
	return stat_max(contents_array) - stat_min(contents_array)
end
	
# arithmetic mean
def mean(contents_array)
	_length = contents_array.size
	_total = 0
		
	for i in contents_array
	_total = _total + i
	end
	return _total.round(10) / _length.round(10)
	end	
	
# arithmetic median
def median(contents_array)
	return nil if contents_array.empty?
	mid, rem = contents_array.length.divmod(2)
	if rem == 0
		contents_array.sort[mid-1,2].inject(:+) / 2.0
	else
		contents_array.sort[mid]
	end
	end

# standard deviation
def stddev(contents_array)
	_length = contents_array.size
	_mean = mean(contents_array)
	_total = 0
	
	for i in contents_array
		_total = _total + ((i - _mean) ** 2)
		end
		_total = _total/_length
	return Math.sqrt(_total)
	end

# z-test calculates outliers
def ztest(contents_array)
	_result = []
	_mean = mean(contents_array)
	_stddev = stddev(contents_array)
	
	for i in contents_array
		_z = ((i - _mean).abs / _stddev)
		if (_z > 3) 
		_result << i
			end
		end
	return _result
	end

#calculate the first quartile 		
def first_quartile(contents_array)
	_median = median(contents_array)
	_fquartile = []
	_length = contents_array.size
	contents_array.sort
	for i in contents_array
		if ((i < _median))
			_fquartile << i
			end
		end
	_fquartile.sort
	return median(_fquartile)
	end

#calculate the third quartile	
def third_quartile(contents_array)
	_median = median(contents_array)
	_tquartile = []
	_length = contents_array.size
	contents_array.sort
	for i in contents_array
		if ((i > _median))
			_tquartile << i
		end
	end
	_tquartile.sort
	return median(_tquartile)
	end
	
f = open("data.txt")
contents_array = []
f.each_line { |line| contents_array << Integer(line)   }
puts "The elements of this file are sorted and presented: "
puts contents_array.sort
puts "Maximum number is : #{stat_max(contents_array)}" 
puts "Minimum number is : #{stat_min(contents_array)}"
puts "The range between numbers is : #{range(contents_array)}"
puts "The mean is : #{mean(contents_array)}"
puts "The median is : #{median(contents_array)}"
puts "First quartile is : #{first_quartile(contents_array)}"
puts "Third quartile is : #{third_quartile(contents_array)}"
puts "The standard deviation is : #{stddev(contents_array)}"
	if (!ztest(contents_array).empty? )
		puts "We calculate the outliers through z-test, which are :"
		puts ztest(contents_array)
	else 
		puts "There are no values in the outliers"
	end
	
f.close
