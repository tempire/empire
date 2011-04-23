use Devel::Dwarn;
use Test::Most;
use Test::Mojo;

use Nempire;
my $t = Test::Mojo->new(app => 'Nempire');

$t->get_ok('/')->status_is(200)->element_exists('h3 > img')
  ->text_is('a.more' => 'Tech');

done_testing;
