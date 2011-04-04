use Devel::Dwarn;
use Test::Most;
use Test::Mojo;

use Nempire;
my $t = Test::Mojo->new(app => 'Nempire');

# Photo not found
$t->get_ok('/photos/bad_title')->status_is(302);

# Photoset not found
$t->get_ok('/photos/12345678912345678')->status_is(302);

# All sets
$t->get_ok('/photos')->status_is(200)
  ->element_exists('div#photosets[class*="thumbnails"]')
  ->content_like(qr/\d+\s+photos in\s+\d+\s+albums/i);

ok my $set_id =
  $t->tx->res->dom('div#photosets > div.photo')->[0]->attrs('id'),
  'set id';
ok my $set_url =
  $t->tx->res->dom('div#photosets > div.photo > a')->[0]->attrs('href'),
  'set url';
ok my $set_title =
  $t->tx->res->dom('div#photosets > div.photo > a div.title')->[0]->text,
  'set title';

is length $set_id => 17;

# Show set
$t->get_ok($set_url)->status_is(200)->text_is(h1 => $set_title);
$t->get_ok("/photos/$set_id")->status_is(200)->text_is(h1 => $set_title);
$t->get_ok("/photos/$set_title")->status_is(200)->text_is(h1 => $set_title);

ok my $photo_url =
  $t->tx->res->dom('div.photoset a.slide')->[0]->attrs('href'), 'photo url';
like $photo_url => qr|^/photos/\d+$|;

# Photo
$t->get_ok($photo_url)->status_is(200)->text_like('h1 a.title' => qr/$set_title/);

done_testing;
