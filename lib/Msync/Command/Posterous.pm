package Msync::Command::Posterous;

use Msync -command;

use Devel::Dwarn;
use Modern::Perl;
use Mojo::UserAgent;
use Net::Posterous;

sub opt_spec {
    return (
        ['all|a'        => 'Sync everything'],
        ['username|u=s' => 'Username'],
        ['password|p=s' => 'Password'],
    );
}

sub abstract   {'Sync Posterous posts'}
sub usage_desc {'msync posterous --all'}

sub validate_args {
    my ($self, $opt, $args) = @_;

    $self->usage_error('Action not specified')
      if !$opt->username
          and !$opt->password;
}

sub execute {
    my ($self, $opt, $args) = @_;
    my $user = $opt->username;
    my $pass = $opt->password;

    my $p = Net::Posterous->new($user, $pass);

    $self->insert_post($_) for $p->get_posts;
}

sub insert_post {
    my $self = shift;
    my $post = shift;

    my $schema = $self->app->schema;

    $schema->resultset('Blog')->update_or_create(
        {   id      => $post->id,
            content => $post->body,
            title   => $post->title,
            created_time => $post->datetime,
        }
    );
}

1;
