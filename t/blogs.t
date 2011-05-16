use Devel::Dwarn;
use Test::Most;
use Test::Mojo;

use Nempire;
my $t = Test::Mojo->new(app => 'Nempire');

# Blog not found
$t->get_ok('/blogs/bad_title')->status_is(302)
  ->header_like(Location => qr|/blogs$|);

# List
$t->get_ok('/blogs')->status_is(200)->element_exists('ul#blogs')
  ->element_exists('#blogs > .blog.snippet');

# One blog entry
$t->get_ok('/blogs/hello_')->status_is(200)
  ->element_exists('ul#blogs')->text_is('h2 > a' => 'Hello!');

done_testing;
