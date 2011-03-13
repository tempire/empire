package Nempire::Blogs;
use Mojo::Base 'Mojolicious::Controller';

sub index {
  my $self = shift;

  $self->schema->resultset('Blogs');

  # Render template "example/welcome.html.ep" with message
  $self->render(message => 'Welcome to the Mojolicious Web Framework!');
}

1;
