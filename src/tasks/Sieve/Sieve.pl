sub sieve {
    my ($n) = @_;
 
    my @primes;
    my $nonPrimes = '';
 
    foreach my $p (2 .. $n) {
        unless (vec($nonPrimes, $p, 1)) {
            for (my $i = $p * $p; $i <= $n; $i += $p) {
                vec($nonPrimes, $i, 1) = 1;
            }
            push @primes, $p;
        }
    }
    @primes
}
 
my $prime_limit;
print "Input the number that you wish to test :";
chomp($prime_limit = <STDIN>);
my @primes = sieve($prime_limit);
print "The primes are: @primes!!!\n";