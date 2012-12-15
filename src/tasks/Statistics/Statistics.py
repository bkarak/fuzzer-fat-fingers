
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

import math, sys


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
	_pos = 0

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
	input_data = []
	fp = open('data.file', 'r')

	for l in fp:
		input_data.append(int(l))

	input_data.sort()

	print 'Min: %d' % (stat_min(input_data),)
	print 'Max: %d' % (stat_max(input_data),)
	print 'Range: %d' % (stat_range(input_data),)
	print '1st Qrt: %d' % (input_data[first_quartile(input_data) - 1],)
	print '3rd Qrt: %d' % (input_data[third_quartile(input_data) - 1],)
	print 'Mean: %.2f' % (mean(input_data),)
	print 'Median: %d' % (input_type[median(input_data) - 1],)
	print 'Stddev: %.2f' % (stddev(input_data),)
	print 'ztest: %s' % (ztest(input_data,))

if __name__ == '__main__':
	main()

