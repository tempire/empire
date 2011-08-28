package Msync;

use App::Cmd::Setup -app;
use File::Slurp 'slurp';
use Nempire::Schema;
#use Net::Riak;

use Mojo::Base -base;

#has riak => sub { Net::Riak->new(host => 'http://127.0.0.1:8098') };
has schema => sub {
    Nempire::Schema->connect(
        'dbi:SQLite:dbname=' . ($ENV{TEST_DB} || 'nempire.db'));
};

1;
