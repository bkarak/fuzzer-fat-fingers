#!/usr/bin/perl
#
# Read a program and randomly replace, add, remove elements

use strict;
use warnings;
use Getopt::Std;

our($opt_t);
getopts('t');

# References to arrays of tokens
my @tokens;

my $line = 0;
while (<>) {
	@{$tokens[$line]} = tokenize();
	if ($opt_t) {
		print join('', @{$tokens[$line]});
		next;
	}
	$line++;
}

# Return $_ split into tokens
sub tokenize {
	return split(/(
	\w+|		# Identifiers
	\s+|		# White space
	\d+|		# Integers
	0[xb]\d+|
	\d+\.\d*|	# Simple floating-point numbers
	\d*\.\d+|
	\"[^"]*\"|	# Simple strings
	\'[^"]*\'|
	\+\+|		# C and C++ multi-character operators
	\-\-|
	\-\>|
	\[\]|
	\.\*|
	\-\>\*|
	\<\<|
	\>\>|
	\<\=|
	\>\=|
	\=\=|
	\!\=|
	\&\&|
	\|\||
	\+\=|
	\-\=|
	\*\=|
	\/\=|
	\%\=|
	\<\<\=|
	\>\>\=|
	\&\=|
	\^\=|
	\|\=|
	\<\=\>|		# Additional Perl operators
	\=\>|
	\=\~|
	\!\~|
	\*\*|
	\~\~|
	\.\.\.|
	\.\.|
	\*\*\=|
	\>\>\>|		# Additional Java operators
	\>\>\>\=|
	.)/x);
}
