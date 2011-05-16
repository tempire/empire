use Devel::Dwarn;
use Test::Most;
use Test::Mojo;

use Test::Database;
$ENV{TEST_DB} = 'test.db';
Test::Database->new_test;

use Nempire;
my $t = Test::Mojo->new(app => 'Nempire');

$t->get_ok('/')->status_is(200)->element_exists('h3')
  ->text_is('a.more' => 'Tech');

# Primary photo
$t->get_ok('/')->status_is(200)
  ->element_exists(
    'div.photos.mini-thumbnails.home > a[href="/photos/4839640560"] > img[src="http://farm5.static.flickr.com/4149/4839028825_4dbcdb0b0e.jpg"]'
  );

# Smaller photo
$t->get_ok('/')->status_is(200)
  ->element_exists(
    'div.photos.mini-thumbnails.home > a[href="/photos/4839028523"] > img[src="http://farm5.static.flickr.com/4085/4839028523_d233aa78e2_s.jpg"]'
  );

done_testing;
