use Devel::Dwarn;
use Test::Most;
use Test::Mojo;

use Nempire;
my $t = Test::Mojo->new(app => 'Nempire');

$t->get_ok('/')->status_is(200)->element_exists('h3')
  ->text_is('a.more' => 'Tech');

# Primary photo
$t->get_ok('/')->status_is(200)
  ->element_exists(
    'div.photos.mini-thumbnails.home > a[href="/photos/4839640560"] > img[src="http://farm5.static.flickr.com/4130/4839640560_991ac99663.jpg"]'
  );

# Smaller photo
$t->get_ok('/')->status_is(200)
  ->element_exists(
    'div.photos.mini-thumbnails.home > a[href="/photos/4839028825"] > img[src="http://farm5.static.flickr.com/4149/4839028825_4dbcdb0b0e_s.jpg"]'
  );

done_testing;
