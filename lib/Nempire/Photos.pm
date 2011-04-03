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

sub show {
    my $self = shift;
    my $id   = $self->stash->{id};

    my $photo = $self->db->resultset('Photo')->find($id)
      or $self->redirect_to("/photos")
      and return;

    $self->stash(photo => $photo);

    $self->render(template => 'photos/show');
}

sub show_set {
    my $self = shift;
    my $id   = $self->stash->{id};

    my $set = $self->db->resultset('Photoset')->by_id_or_title($id)
      or $self->redirect_to("/photos")
      and return;

    $self->stash(set => $set);

    $self->render(template => 'photos/show_set');
}

1;
