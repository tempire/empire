package Nempire::Schema::ResultSet::Photoset;

use strict;
use warnings;
use base "DBIx::Class::ResultSet";

sub by_id_or_title {
  my $self  = shift;
  my $title = shift;

  return $self->find($title) if $title =~ /^\d+$/;

  return $self->find( { title => { "LIKE" => $title } } );
}

sub faces {
  return shift->by_id_or_title('Faces of Glen');
}

1;

=head1 NAME

Nempire::Schema::ResultSet::Photoset

=head1 METHODS

=head2 id_or_title

Find photoset by either id or title;

=head2 faces

Faces of Glen Photoset

=cut
