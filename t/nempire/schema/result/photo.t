use Modern::Perl;
use Nempire::Schema;
use Devel::Dwarn;

use Test::Most;
use Test::Database;

my $photo_id      = '4839028825';
my $next_photo_id = '4839028523';
my $prev_photo_id = '4839640560';
my $photoset_id   = '72157624605770036';

my $schema = Test::Database->new_test->schema;
my $photo  = $schema->resultset('Photo')->find($photo_id);

is $photo->location => 'League City, Texas';
is $photo->set->id      => $photoset_id,   'photoset id';
is $photo->previous->id => $prev_photo_id, 'previous photo';
is $photo->next->id     => $next_photo_id, 'next photo';

like $photo->time_since => qr/\d+ days and \d+ hours ago/;

done_testing;
