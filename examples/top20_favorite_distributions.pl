use strict;
use warnings;
use Data::Printer;

use MetaCPAN::Client;

# TOP 20 FAVORITE DISTRIBUTIONS

my $mcpan = MetaCPAN::Client->new();
my $favs  = $mcpan->all('favorites', {
    facets => {
        distribution => {
            terms => {
                field => "distribution",
                size  => 20,
                order => "count",
            }
        },
    }
});

print "TOP 20 FAVORITE DISTRIBUTIONS:\n";

my $count = 1;
for ( @{ $favs->facets->{distribution}{terms} } ) {
    printf "%3d) %5d  %-20s\n", $count++, @{$_}{qw/count term/};
}
