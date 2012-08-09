use strict;
 
sub F
{
    my $n = shift;
    return 1 if $n==0;
    return $n - M(F($n-1));
}
 
sub M
{
    my $n = shift;
    return 0 if $n==0;
    return $n - F(M($n-1));
}
 
my @ra = ();
my @rb = ();
foreach my $i (0 .. 19) {
    push @ra, F($i);
    push @rb, M($i);
}
print join(" ", @ra) . "\n";
print join(" ", @rb) . "\n";
sub F {!$_[0] or $_[0] - M(F($_[0]-1))}
sub M {$_[0] and $_[0] - F(M($_[0]-1))}
 
for my $f (\&F, \&M)
    {print "@{[map $f->($_), 0..20]}\n"}