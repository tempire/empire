package Nempire::Photos;

use Mojo::Base 'Mojolicious::Controller';

sub index {
    my $self = shift;

    $self->stash(
        sets        => [$self->db->resultset('Photoset')->search],
        photo_count => $self->db->resultset('Photo')->count,
    );

    $self->render(template => 'photos/index');
}

1;
