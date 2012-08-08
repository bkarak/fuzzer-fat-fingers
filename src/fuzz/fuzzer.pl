#!/usr/bin/perl
#
# Read a program and randomly replace, add, remove elements

use strict;
use warnings;

# Parse arguments
use Getopt::Std;
our($opt_t, $opt_r, $opt_d);
getopts('rtd');

testTokenType() if ($opt_t);

# Ensure repeatable results
srand 1234567 unless ($opt_r);

# References to arrays of tokens
my @tokens;

# Read program lines
my $line = 0;
while (<>) {
	@{$tokens[$line]} = tokenize();
	if ($opt_t) {
		print join('', @{$tokens[$line]});
		next;
	}
	$line++;
}

exit 0 if ($opt_t);

# Introduce a single fuzz
similarSubstitutionFuzz();

# Print program
foreach my $l (@tokens) {
	print join('', @{$l});
}

# Substitute a single token with a similar one
sub similarSubstitutionFuzz {
	# Try until a substitution succeeds
	for (;;) {
		# Select first token
		my $lineIndex = int(rand($line));
		my $tokenIndex = int(rand($#{$tokens[$lineIndex]}));
		my $class = tokenClass(${$tokens[$lineIndex]}[$tokenIndex]);
		next if ($class eq 'space');

		# Try replacing this token with an equivalent one
		for (my $try = 0; $try < 100; $try++) {
			my $lineIndex2 = int(rand($line));
			my $tokenIndex2 = int(rand($#{$tokens[$lineIndex2]}));
			my $class2 = tokenClass(${$tokens[$lineIndex2]}[$tokenIndex2]);
			if (${$tokens[$lineIndex]}[$tokenIndex] ne ${$tokens[$lineIndex2]}[$tokenIndex2] &&
				$class2 eq $class) {
				print "Changing [${$tokens[$lineIndex]}[$tokenIndex]] of class $class into [${$tokens[$lineIndex2]}[$tokenIndex2]] of class $class2\n" if ($opt_d);
				${$tokens[$lineIndex]}[$tokenIndex] = ${$tokens[$lineIndex2]}[$tokenIndex2];
				return;
			}
		}
	}
}

# Return the type of the passed token
sub tokenClass {
	my ($token) = @_;

	if ($token =~ m/^[A-Za-z_]/) {
		return 'id';
	} elsif ($token =~ m/^[ \t]*$/) {
		return 'space';		# And empty
	} elsif ($token =~ m/^((\d+)|(0[xb]\d+))$/) {
		return 'int';
	} elsif ($token =~ m/^\d/) {
		return 'float';
	} elsif ($token =~ m/^(["'])/) {
		return $1;		# String or char literal
	} else {
		return 'op';
	}
}

# Test the tokenClass sub
sub testTokenType {
	ensure (q<tokenClass('hello') eq 'id'>);
	ensure (q<tokenClass(' ') eq 'space'>);
	ensure (q<tokenClass('42') eq 'int'>);
	ensure (q<tokenClass('3.14') eq 'float'>);
	ensure (q<tokenClass('"hello"') eq '"'>);
	ensure (q<tokenClass('++') eq 'op'>);
}

# Complain and exit if passed expression evaluates to false
sub ensure {
	my($expr) = @_;

	if (!eval($expr)) {
		print STDERR "Failure of [$expr]\n";
		exit 1;
	}
}

# Return $_ split into tokens
sub tokenize {
	return split(/(
	[A-Za-z_]\w+|	# Identifiers
	[ \t]+|		# White space
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
