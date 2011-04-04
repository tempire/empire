use Modern::Perl;
use Data::Dumper;
use FindBin;
use DBI;

use Test::More tests => 1;

# Export $schema
use Test::Database test => 'schema';

is ref $schema => 'Nempire::Schema';
