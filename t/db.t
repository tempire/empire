use Modern::Perl;
use Test::Most;

use Nempire::Schema;

ok +Nempire::Schema->connect('dbi:SQLite:dbname=nempire.db');

done_testing;
