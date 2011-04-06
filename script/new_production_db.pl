use lib 'lib';
use Modern::Perl;
use Test::Database;

my $file = Test::Database->new_production->file;
`open $file`;
