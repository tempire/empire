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
      or $self->redirect_to("/photos"), return;

    $self->stash(photo => $photo);

    $self->render(template => 'photos/show');
}

sub show_set {
    my $self = shift;
    my $id   = $self->stash->{id};

    my $set = $self->db->resultset('Photoset')->by_id_or_title($id)
      or $self->redirect_to("/photos"), return;

    $self->stash(set => $set);

    $self->render(template => 'photos/show_set');
}

1;

=head1 NAME

Nempire::Photos

=head1 DESCRIPTION

/photos controller

=head1 ACTIONS

=head2 index

GET /photos

=head2 show

GET /photos/:photo_id

=head2 show_set

GET /photos/:set_id

=cut
