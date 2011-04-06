package Nempire;

use Nempire::Schema;
use Mojo::Base 'Mojolicious';
use Devel::Dwarn;

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

    $r->add_condition(

        # Requested id is a photoset?
        photoset => sub {
            my ($r, $c, $captures, $pattern) = @_;

            my $id = $captures->{id};
            return 1 if $id !~ /^\d+$/ or $id =~ /^\d+$/ and length $id == 17;
        }
    );

    $r->get('/photos')->to('photos#index');
    $r->get('/photos/:id')->over('photoset')->to('photos#show_set');
    $r->get('/photos/:id')->to('photos#show');

    $r->get('/blogs')->to('blogs#index');
    $r->get('/blogs/(*tags)')->to('blogs#index');
}

1;
