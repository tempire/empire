package Nempire::Schema::ResultSet::Photo;

use strict;
use warnings;
use base "DBIx::Class::ResultSet";

sub latest {
    my $self  = shift;
    my $count = shift;

    return $self->search( undef,
        { order_by => { -desc => 'taken' }, page => 1, rows => $count } );
}

1;

=head1 NAME

Nempire::Schema::ResultSet::Photoset

=head1 METHODS

=head2 latest

Return latest photos by count

=cut
