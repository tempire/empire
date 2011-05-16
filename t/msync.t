use Modern::Perl;
use App::Cmd::Tester;
use Devel::Dwarn;
use Msync;
use Test::Most;

use Test::Database;
$ENV{TEST_DB} = 'test.db';
Test::Database->new_test;

ok test_app(Msync => [qw'flickr --all']), 'sync all photosets';

done_testing;
