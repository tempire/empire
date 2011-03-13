package Nempire;

use Nempire::Schema;
use Mojo::Base 'Mojolicious';

#has schema => sub {
#    my $dsn = 'dbi:SQLite:' . ($ENV{TEST_DB} || 'nempire.db');
#    return Nempire::Schema->connect($dsn);
#};

sub startup {
    my $self = shift;

    $self->plugin('pod_renderer');

    $self->helper(
        db => sub {
            my $dsn = 'dbi:SQLite:' . ($ENV{TEST_DB} || 'nempire.db');
            return Nempire::Schema->connect($dsn);
        }
    );

    # Routes
    my $r = $self->routes;

    $r->get('/photos')->to('photos#index');
}

1;
