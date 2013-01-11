sub test_num {
    my $f = shift;
    my $s = shift;
    if ($f < $s){
        return -1; # returns -1 if $f is less than $s
    } elsif ($f > $s) {
        return 1; # returns 1 if $f is greater than $s
    } elsif ($f == $s) {
# = operator is an assignment
# == operator is a numeric comparison
       return 0; # returns 0 $f is equal to $s
    };
};

# Get input, test and display
print "Enter two integers: ";
($x, $y) = split ' ', <>;
print $x, (" is less than ", " is equal to ",
           " is greater than ")[test_num($x, $y) + 1], $y, "\n";