#!/usr/bin/perl
#
# Read a program and randomly replace, add, remove elements

use strict;
use warnings;

# Parse arguments
use Getopt::Std;
our($opt_d, $opt_f, $opt_l, $opt_n, $opt_s, $opt_r, $opt_t);
$opt_n = 1;
$opt_f = 'SimilarSubstitution';
$opt_s = 0;

my @fuzzFunctions = qw(
	IdentifierSubstitution
	IntegerPerturbation
	RandomCharacterSubstitution
	RandomTokenSubstitution
	SimilarSubstitution
);

my $fuzzRe = join('|', @fuzzFunctions);

usage('Illegal option') unless (getopts('df:ln:rs:t'));
usage('Unknown fuzz function ' . $opt_f) if ($opt_f !~ m/^($fuzzRe)$/);

if ($opt_l) {
	print join(' ', @fuzzFunctions);
	exit 0;
}

sub usage {
	print STDERR qq{$_[0]
usage: $0 [-d] [-r] [-t]
-d	Enable debug output
-f fuzz	Select fuzz function
-l	List available fuzzing functions
-n n	Apply fuzz function n times
-r	Use a random seed
-s s	Offset random seed by s
-t	Execute unit tests and exit

fuzz function: $fuzzRe
};
	exit 1;
}

testTokenType() if ($opt_t);

# Ensure repeatable results
srand(1234567 + $opt_s) unless ($opt_r);

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

# Fuzz
for (my $i = 0; $i < $opt_n; $i++) {
	eval("fuzz$opt_f()");
}

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
		next if ($class eq 'space' || $class eq 'gdel');

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

# Substitute a single character with a random one
# This simulates an editor error or typo
sub fuzzRandomCharacterSubstitution {
	my $lineIndex = int(rand($line));
	my $tokenIndex = int(rand($#{$tokens[$lineIndex]}));
	my $tokenLength = length(${$tokens[$lineIndex]}[$tokenIndex]);
	substr(${$tokens[$lineIndex]}[$tokenIndex], int(rand($tokenLength)), 1) = chr(int(rand(256)));
}

# Substitute a single token with a random one
# This simulates a typo
sub fuzzRandomTokenSubstitution {
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

# Perturb an integer token by one
# This simulates an off by one error or a misunderstanding of a status code
sub fuzzIntegerPerturbation {
	# Try until a substitution succeeds
	for (my $try = 0; $try < $ntokens; $try++) {
		# Select first token
		my $lineIndex = int(rand($line));
		my $tokenIndex = int(rand($#{$tokens[$lineIndex]}));
		if (tokenClass(${$tokens[$lineIndex]}[$tokenIndex]) eq 'int') {
			${$tokens[$lineIndex]}[$tokenIndex] += int(rand(2)) * 2 - 1;
			return;
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
	} elsif ($token =~ m/^([()\[\]\{\}])/) {
		return 'gdel';		# Group delimiter
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
	ensure (q<tokenClass('(') eq 'gdel'>);
	ensure (q<tokenClass('}') eq 'gdel'>);
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
