use lib 'lib';
use Nempire::Schema;
use Data::Dump 'pp';

my $dsn = 'dbi:SQLite:dbname=nempire.db';
my $schema =
  Nempire::Schema->connect($dsn, '', '',
    {quote_char => '`', name_sep => '.'});

my $id = pop @ARGV;

if (length $id == 17) {
    warn pp { $schema->resultset('Photoset')->find($id)->get_columns };
}
else {
    warn pp { $schema->resultset('Photo')->find($id)->get_columns };
}
