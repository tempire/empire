use Test::Most;
use Test::Mojo;

use Nempire;

my $t = Test::Mojo->new(app => 'Nempire');
$t->get_ok('/photos')->status_is(200)
  ->element_exists('div#photosets')
  ->content_like(qr/\d+\s+photos in\s+\d+\s+albums/i);

done_testing;
