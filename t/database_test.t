use Modern::Perl;
use Data::Dumper;
use FindBin;
use DBI;

use Test::Most;

BEGIN {
    $ENV{TEST_DB} = $FindBin::Bin . '/test.db';
}

# Compile-time on-disk db generation
use Test::Database 'test';

ok my $dbc = DBI->connect("dbi:SQLite:dbname=$ENV{TEST_DB}"), 'Test database';
ok $dbc->selectrow_array("SELECT id FROM photos LIMIT 1"), 'row';
ok unlink($ENV{TEST_DB}), 'remove test db';

delete $ENV{TEST_DB};

# Runtime in-memory db
ok my $t = Test::Database->new_test, 'test db @ runtime';
ok $t->schema->resultset('Photo')->search->count, 'rows';

done_testing;
