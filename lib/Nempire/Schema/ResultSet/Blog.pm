package Nempire::Schema::ResultSet::Blog;

use Modern::Perl;
use base 'DBIx::Class::ResultSet';

sub by_tags {
    my $self = shift;
    my @tags = @_;

    return if !@tags;

    my $tags = $self->search_related(tags => {name => [@tags]});

    return map $_->blog, $tags->all;
}

1;

=head1 NAME

Nempire::Schema::ResultSet::Blog

=head1 METHODS

=head2 by_tags

Search blogs by related tags

=cut
