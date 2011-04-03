use Devel::Dwarn;
use Test::Most;
use Test::Mojo;

use Nempire;
my $t = Test::Mojo->new(app => 'Nempire');

# List of sets
$t->get_ok('/photos')->status_is(200)
  ->element_exists('div#photosets[class*="thumbnails"]')
  ->content_like(qr/\d+\s+photos in\s+\d+\s+albums/i);

ok my $album_id =
  $t->tx->res->dom('div#photosets > div.photo')->[0]->attrs('id'),
  'album id';
ok my $album_url =
  $t->tx->res->dom('div#photosets > div.photo > a')->[0]->attrs('href'),
  'album url';
ok my $album_title =
  $t->tx->res->dom('div#photosets > div.photo > a div.title')->[0]->text,
  'album title';


is length $album_id => 17;

# Show set
$t->get_ok($album_url)->status_is(200)->text_is(h1 => $album_title);
$t->get_ok("/photos/$album_id")->status_is(200)->text_is(h1 => $album_title);
$t->get_ok("/photos/$album_title")->status_is(200)
  ->text_is(h1 => $album_title);

done_testing;
