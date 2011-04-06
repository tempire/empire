package Nempire::Blogs;

use Mojo::Base 'Mojolicious::Controller';
use Devel::Dwarn;

sub index {
    my $self = shift;

    # Specified tags to search for
    my @tags = grep $_ ne 'tag',
      @{Mojo::Path->new($self->stash->{tags})->parts};

    # Default tag
    @tags = qw/ personal / if !@tags;
    warn "@tags";

    my @blogs = $self->db->resultset('Blog')->by_tags(@tags);
    return $self->render(status => 404) if !@blogs;

    $self->render(
        template => 'blogs/index',
        blogs    => \@blogs,
    );
}

1;
