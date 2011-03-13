use Modern::Perl;
use Nempire::Schema;
use Devel::Dwarn;

use Test::Most;
use Test::Database;

my $schema = Test::Database->new_test->schema;
my $set = $schema->resultset('Photoset')->find(1);

is ref $set->date         => 'DateTime';
is $set->date->month_abbr => 'Jan';
is $set->date->year       => 2001;

is $set->region => 'Alliance, Nebraska';
is $set->url_title => 'a_title_';

done_testing;
