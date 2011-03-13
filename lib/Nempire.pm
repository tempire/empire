package Nempire;

use Mojo::Base 'Mojolicious';

has schema => sub {
    my $dsn = 'dbi:SQLite:' . ( $ENV{TEST_DB} || 'nempire.db' );
    return N::Schema->connect($dsn);
};

sub startup {
  my $self = shift;

  $self->plugin('pod_renderer');

  # Routes
  my $r = $self->routes;

  # Normal route to controller
  $r->route('/welcome')->to('example#welcome');
}

1;
