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

    my @blogs = $self->db->resultset('Blog')->by_tags(@tags);
    return $self->redirect_to('/blogs') if !@blogs;

    $self->render(
        template => 'blogs/index',
        blogs    => \@blogs,
    );
}

sub show {
    my $self = shift;
    my $name = $self->stash('name');

    my $blog = $self->db->resultset('Blog')->find({id => $name});
    $blog = $self->db->resultset('Blog')->find({title => {LIKE => $name}})
      if !$blog;

    return $self->redirect_to('/blogs') if !$blog;

    $self->render(
        template => 'blogs/show',
        blog     => $blog,
    );
}

1;
