my @params = @ARGV;
my $params_size = @ARGV; 
my $second = $ARGV[1];
my $fifth = $ARGV[4];
use Getopt::Long;
GetOptions ( 
    'help|h'     => \my $help,
    'verbose|v'  => \my $verbose,
);