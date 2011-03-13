package Nempire::Photos;
use Devel::Dwarn;
use Mojo::Base 'Mojolicious::Controller';

sub index {
    my $self = shift;

    $self->stash(
        sets        => [$self->db->resultset('Photoset')->search->all],
        photo_count => $self->db->resultset('Photo')->search->count,
    );

    $self->render(template => 'photos/index');
}

1;
