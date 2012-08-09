#!/usr/bin/perl
#
# Read a program and randomly replace, add, remove elements

use strict;
use warnings;

# Parse arguments
use Getopt::Std;
our($opt_t, $opt_r, $opt_d);
if (!getopts('rtd')) {
	print STDERR qq{usage: $0 [-d] [-r] [-t]
-d	Enable debug output
-r	Use a random seed
-t	Execute unit tests and exit
};
	exit 1;
}

testTokenType() if ($opt_t);

# Ensure repeatable results
srand 1234567 unless ($opt_r);

# References to arrays of tokens
my @tokens;

# Total number of tokens
my $ntokens = 0;

# Read program lines
my $line = 0;
while (<>) {
	@{$tokens[$line]} = tokenize();
	$ntokens += scalar(@{$tokens[$line]});
	if ($opt_t) {
		print join('', @{$tokens[$line]});
		next;
	}
	$line++;
}

exit 0 if ($opt_t);

# Introduce a single fuzz
fuzzSimilarSubstitution();

# Print program
foreach my $l (@tokens) {
	print join('', @{$l});
}

exit 0;

# Substitute a single token with a similar one
# This simulates absent-mindendness
sub fuzzSimilarSubstitution {
	# Try until a substitution succeeds
	for (my $try2 = 0; $try2 < $ntokens; $try2++) {
		# Select first token
		my $lineIndex = int(rand($line));
		my $tokenIndex = int(rand($#{$tokens[$lineIndex]}));
		my $class = tokenClass(${$tokens[$lineIndex]}[$tokenIndex]);
		next if ($class eq 'space');

		# Try replacing this token with an equivalent one
		for (my $try = 0; $try < $ntokens; $try++) {
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
	exit 1;
}

# Substitute a single token with a random one
# This simulates a typo
sub fuzzRandomSubstitution {
	# Try until a substitution succeeds
	for (my $try2 = 0; $try2 < $ntokens; $try2++) {
		# Select first token
		my $lineIndex = int(rand($line));
		my $tokenIndex = int(rand($#{$tokens[$lineIndex]}));
		my $class = tokenClass(${$tokens[$lineIndex]}[$tokenIndex]);
		next if ($class eq 'space');

		# Try replacing this token with an equivalent one
		for (my $try = 0; $try < $ntokens; $try++) {
			my $lineIndex2 = int(rand($line));
			my $tokenIndex2 = int(rand($#{$tokens[$lineIndex2]}));
			my $class2 = tokenClass(${$tokens[$lineIndex2]}[$tokenIndex2]);
			next if ($class2 eq 'space');
			if (${$tokens[$lineIndex]}[$tokenIndex] ne ${$tokens[$lineIndex2]}[$tokenIndex2]) {
				print "Changing [${$tokens[$lineIndex]}[$tokenIndex]] of class $class into [${$tokens[$lineIndex2]}[$tokenIndex2]] of class $class2\n" if ($opt_d);
				${$tokens[$lineIndex]}[$tokenIndex] = ${$tokens[$lineIndex2]}[$tokenIndex2];
				return;
			}
		}
	}
	exit 1;
}

# Substitute a single identifier token with another one
# This simulates a semantic error
sub fuzzIdentifierSubstitution {
	# Try until a substitution succeeds
	for (my $try2 = 0; $try2 < $ntokens; $try2++) {
		# Select first token
		my $lineIndex = int(rand($line));
		my $tokenIndex = int(rand($#{$tokens[$lineIndex]}));
		my $class = tokenClass(${$tokens[$lineIndex]}[$tokenIndex]);
		next unless ($class eq 'id');

		# Try replacing this token with an equivalent one
		for (my $try = 0; $try < $ntokens; $try++) {
			my $lineIndex2 = int(rand($line));
			my $tokenIndex2 = int(rand($#{$tokens[$lineIndex2]}));
			my $class2 = tokenClass(${$tokens[$lineIndex2]}[$tokenIndex2]);
			next unless ($class2 eq 'id');
			if (${$tokens[$lineIndex]}[$tokenIndex] ne ${$tokens[$lineIndex2]}[$tokenIndex2]) {
				print "Changing [${$tokens[$lineIndex]}[$tokenIndex]] of class $class into [${$tokens[$lineIndex2]}[$tokenIndex2]] of class $class2\n" if ($opt_d);
				${$tokens[$lineIndex]}[$tokenIndex] = ${$tokens[$lineIndex2]}[$tokenIndex2];
				return;
			}
		}
	}
	exit 1;
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
