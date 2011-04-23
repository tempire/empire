use Modern::Perl;
use Nempire::Schema;
use Devel::Dwarn;

use Test::Most;
use Test::Database;

my $blog_id        = '1';
my $blog_title     = 'Hello!';
my $blog_url_title = 'hello_';

my $schema = Test::Database->new_test->schema;
my $blog   = $schema->resultset('Blog')->find($blog_id);

is $blog->url_title => $blog_url_title, 'url title';
is ref $blog->created_time => 'DateTime', 'DateTime object';
is $blog->created_time_string => 'Wednesday, April  6, 2011 at  2:27AM',
  'pretty time string';
is $blog->snippet => 'It develops because people are cesspools of fear.',
  'blog text snippet';

# Tags
is $blog->tags->first->name => 'personal', 'blog tag';
ok !$schema->resultset('Blog')->by_tags(qw/bad/);
is [$schema->resultset('Blog')->by_tags(qw/personal/)]->[0]->title =>
  $blog_title;
is [$schema->resultset('Blog')->by_tags(qw/test/)]->[0]->title => $blog_title;
is [$schema->resultset('Blog')->by_tags(qw/personal test/)]->[0]->title =>
  $blog_title;
is $schema->resultset('Blog')->hidden->all     => 1, '1 hidden entry';
is $schema->resultset('Blog')->not_hidden->all => 3, '3 non-hidden entries';

# Latest non-hidden entry
is $schema->resultset('Blog')->latest->title => 'Tech', 'latest entry';

done_testing;
