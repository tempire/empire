use Modern::Perl;
use Nempire::Schema;
use Devel::Dwarn;

use Test::Most;
use Test::Database;

my $photo_id = '4839028825';

my $schema = Test::Database->new_test->schema;
my $photo  = $schema->resultset('Photo')->find($photo_id);

is $photo->location => 'League City, Texas';

done_testing;
