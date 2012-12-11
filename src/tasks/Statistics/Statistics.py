
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

import math


# range
def stat_range(input_data):
	return stat_max(input_data) - stat_min(input_data)


# maximum value
def stat_max(input_data):
	return max(input_data)


# minimum value
def stat_min(input_data):
	return min(input_data)


# third quartile
def third_quartile(input_data):
	_length = len(input_data)

	if (3*_length) / 4 == 1:
		return (3*_length) + 1

	return 3*_length

# first quartile
def first_quartile(input_data):
	_length = len(input_data)

	if _length % 4 == 1:
		return (_length / 4) + 1

	return _length / 4

# median
def median(input_data):
	_length = len(input_data)

	if _length % 2 == 1:
		return (_length / 2) + 1
	
	return _length / 2


# arithmetic mean
def mean(input_data):
	_length = len(input_data)
	_total = 0
	
	for i in input_data:
		_total = _total + i
	
	return float(_total) / float(_length)


# standard deviation
def stddev(input_data):
	_length = len(input_data)
	_mean = mean(input_data)
	_total = 0
	
	for i in input_data:
		_total = _total + math.pow((i - _mean), 2)
	
	_total = float(_total) / float(_length)
	
	return math.sqrt(_total)


def ztest(input_data):
	_result = []
	_mean = mean(input_data)
	_stddev = stddev(input_data)
	
	for i in input_data:
		_z = float(math.fabs(float(i) - float(_mean))) / float(_stddev)
		if _z < 3:
			_result.append(i)
	
	return _result

def main():
	pass

if __name__ == '__main__':
	main()