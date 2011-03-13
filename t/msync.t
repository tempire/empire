use Modern::Perl;
use App::Cmd::Tester;
use Devel::Dwarn;
use Msync;

use Test::Most;

## Connected to db
#ok +Msync->new->schema->resultset('Photoset')->update_or_create(
#    {   id          => 1,
#        title       => 'whatever',
#        server      => 'whatever',
#        farm        => 'whatever',
#        photos      => 3,
#        videos      => 3,
#        secret      => 3,
#        idx         => 3,
#        description => 3
#    }
#)->delete;
#
#
#ok test_app(Msync => [qw'flickr --all']), 'sync all photosets';
#
##    # add key/value
##    is test_app('App::karyn' => [qw/add --bucket b1 --key k1 --value v1/])
##      ->stdout => "204 No Content (Success)\n",
##      'add key/value';
##};

ok 1;

done_testing;
