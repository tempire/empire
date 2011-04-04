use Modern::Perl;
use Data::Dumper;
use FindBin;
use DBI;
use Cwd;
use Test::MockObject;

use Test::Most tests => 2;

BEGIN {
    # Compile-time on-disk db generation
    eval "use Test::Database 'not production or test'";
    like $@ => qr/^Accepts either 'test' or 'production' arguments/, 'wrong database type';
}

# Remove if previous test was interrupted
my $badfile = 't/fixtures/badformat.pl';
unlink $badfile;

# Invalid perl fixture
open my $file, '>', $badfile;
print $file '.';
close $file;

# Fails on perl bad fixture
dies_ok { Test::Database->new_test };

# Remove
unlink $badfile;
