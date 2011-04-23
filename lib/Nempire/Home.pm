package Nempire::Home;

use Mojo::Base 'Mojolicious::Controller';
use Devel::Dwarn;

sub index {
    my $self = shift;

    my $blog = $self->db->resultset('Blog')->latest;
    my $photos =
      [$self->db->resultset('Photoset')->find('72157618164628634')->photos];

    $self->render(
        blog     => $blog,
        photos   => $photos,
        template => 'home/index'
    );
}

1;
