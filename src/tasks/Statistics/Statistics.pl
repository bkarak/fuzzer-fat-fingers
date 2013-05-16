#!/usr/bin/perl
#
# Basic statistical measurements
# includes:
#
#
# * min, max range
# * 1st, 2rd Quartile
# * median
# * Arithmetic mean
# * standard deviation
# * z-test implementation to find outliers
#

use warnings;
use strict;

my @unsorted = ();
open(F, "<", "data.txt") or die "Failed";
while(<F>) { chomp; push(@unsorted, int($_));}
close (F);
my $min;
my $max;
my $range;
my @array = sort {$a <=> $b} @unsorted;

# Arithmetic Mean  subroutine
sub my_mean{
	my $arraySize;
	my $sum = 0;
	for ( @array) {
	$sum += $_;
	}
	$arraySize = scalar(@array);
	$arraySize = $#array + 1;
	return my $mean = $sum / $arraySize;
}

# Min subroutine
sub my_min{
	for(@array){
		 $min = $_ if !$min || $_ < $min;
		}
	return $min;
}

# Max subroutine
sub my_max{
	for(@array){
		$max = $_ if !$max || $_ > $max;
}
return $max;
}

# Range subroutine
sub my_range{
	$range = my_max(@array) - my_min(@array);
	return $range;
}

# Median subroutine
sub my_median{
	my $med;
	if( (@array % 2) == 1 ) {
        $med = $array[((@array+1) / 2)-1];
    } else {
        $med = ($array[(@array / 2)-1] + $array[@array / 2]) / 2;
    }
    return $med;
}

# Standard Deviation subroutine
sub my_stdev{
	my $num;
	$num = scalar(@array);
	$num = $#array + 1;
	my $x;
	my $avg = my_mean(@array);
	my $sqsum = 0;
	foreach $x(@array){
	$sqsum += ($x - $avg)*($x - $avg) ;
	}
	my ($var)=$sqsum/$num;
	my ($stand_dev)=sqrt ($var);
	return $stand_dev;
}

# Z-test subroutine
sub my_ztest{
	my @ztest;
	my $avg = my_mean(@array);
	my $sd = my_stdev(@array);
	my $temp;
	foreach $_ (@array){
	$temp = abs( $_ - $avg)/ $sd;
	if ($temp > 3){
		push(@ztest, "$_");
	}
	}
	if (@ztest){
		return @ztest}
	else {
		return "No z values";
	}
	
}

# 1st quartile subroutine
sub my_firstquartile{
	my $med = my_median(@array);
	my @temp;
	foreach $_ (@array){
	if ($_ < $med){
		push(@temp, "$_");
	}
	}
	my $quart;
	my @vals = sort {$a <=> $b} @temp;
	if( (@vals % 2) == 1 ) {
        $quart = $vals[((@vals+1) / 2)-1];
    } else {
        $quart = ($vals[(@vals / 2)-1] + $vals[@vals / 2]) / 2;
    }
    return $quart;
}

# 3nd quartile subroutine
sub my_thirdquartile{
	my $med = my_median(@array);
	my @temp;
	foreach $_ (@array){
	if ($_ > $med){
		push(@temp, "$_");
	}
	}
	my $quart;
	my @vals = sort {$a <=> $b} @temp;
	if( (@vals % 2) == 1 ) {
        $quart = $vals[((@vals+1) / 2)-1];
    } else {
        $quart = ($vals[(@vals / 2)-1] + $vals[@vals / 2]) / 2;
    }
    return $quart;
}

print @array, "\n";

print "Average is : ",my_mean(@array), "\n";
print "Minimum value is:", my_min(@array),"\n";
print "Maximum value is:", my_max(@array),"\n";
print "Range between values is :", my_range(@array), "\n";
print "Median is: ", my_median(@array), "\n";
print "Standard deviation is: ", my_stdev(@array), "\n";
print "Z-test values are: ", my_ztest(@array), "\n";
print "1st quartile is : ", my_firstquartile(@array), "\n";
print "3nd quartile is : ", my_thirdquartile(@array), "\n";
