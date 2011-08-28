use Modern::Perl;
use Nempire::Schema;
use Devel::Dwarn;

use Test::Most;
use Test::Database;

my $photo_id      = '4839028825';
my $next_photo_id = '4839028523';
my $prev_photo_id = '4839640560';
my $photoset_id   = '72157618164628634';

my $schema = Test::Database->new_test->schema;
my $photo  = $schema->resultset('Photo')->find($photo_id);

is $photo->location => 'League City, Texas';

ok $photo->update({region => undef});
is $photo->location => 'League City', 'location';

ok $photo->update({locality => undef, region => 'Texas'});
is $photo->location => 'Texas', 'location';

is $photo->set->id      => $photoset_id,   'photoset id';
is $photo->previous->id => $prev_photo_id, 'previous photo';
is $photo->next->id     => $next_photo_id, 'next photo';

ok !$photo->previous->previous, 'no previous photo';
ok !$photo->next->next,         'no next photo';

ok $photo->update({idx => undef}), 'clear idx';
ok !$photo->previous, 'returns false';
ok !$photo->next,     'returns false';

like $photo->time_since => qr/\d+ \w+ and \d+ \w+ ago/, 'time since';
ok $photo->update({taken => undef}), 'clear taken';
ok $photo = $schema->resultset('Photo')->find($photo_id), 'refresh';
ok !$photo->time_since, 'no time since';

done_testing;
