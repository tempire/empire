package EmpireX::Flickr;

use Devel::Dwarn;
use Flickr::API;
use File::Slurp 'slurp';
use Mojo::DOM;
use Mojo::UserAgent;

use Mojo::Base -base;

my $flickr = eval slurp '/etc/nempire.conf';
die "Cannot open flickr conf: /etc/nempire.conf" if !$flickr;

has 'flickr';
has api_key => $flickr->{api_key};
has secret  => $flickr->{secret};
has user_id => $flickr->{user_id};

sub url {
    my $self   = shift;
    my $method = shift;
    my @params = @_;

    return Mojo::URL->new('http://api.flickr.com/services/rest/')->query(
        method         => $method,
        user_id        => $self->user_id,
        api_key        => $self->api_key,
        format         => 'json',
        nojsoncallback => 1,
        @params
    );
}


sub login {
    my $self = shift;
    my $auth = shift;

    my $client =
      Flickr::API->new({key => $self->api_key, secret => $self->secret});

    $self->flickr($client);

    return $self;
}

sub echo {
    return shift->flickr->execute_method('flickr.test.echo');
}

sub photosets {
    my $self = shift;

    my $sets =
      Mojo::UserAgent->new->get($self->url('flickr.photosets.getList'))
      ->res->json->{photosets}->{photoset}
      or die 'No photosets returned';

    return map {
        $_->{title}       = $_->{title}->{_content};
        $_->{description} = $_->{description}->{_content};
        $_;
    } @$sets;
}

sub photos {
    my $self        = shift;
    my $photoset_id = shift;

    my $photos = Mojo::UserAgent->new->get(
        $self->url('flickr.photosets.getPhotos', photoset_id => $photoset_id))
      ->res->json->{photoset}->{photo}
      or die 'No photos found in photoset_id ' . $photoset_id;

    return @$photos;
}

sub photo_sizes {
    my $self     = shift;
    my $photo_id = shift;

    my $sizes = Mojo::UserAgent->new->get(
        $self->url('flickr.photos.getSizes', photo_id => $photo_id))
      ->res->json->{sizes}->{size}
      or die 'No sizes found for photo_id ' . $photo_id;

    return map { lc $_->{label} => $_->{source} } @$sizes;
}

sub photo_info {
    my $self     = shift;
    my $photo_id = shift;

    my $info = Mojo::UserAgent->new->get(
        $self->url('flickr.photos.getInfo', photo_id => $photo_id))
      ->res->json->{photo}
      or die 'Photo ' . $photo_id . ' not found';

    return (
        id          => $photo_id,
        description => $info->{description}->{_content},
        lat         => $info->{location}->{latitude},
        lon         => $info->{location}->{longitude},
        region      => $info->{location}->{region}->{_content},
        locality    => $info->{location}->{locality}->{_content},
        country     => $info->{location}->{country}->{_content},
        taken       => $info->{dates}->{taken},
    );
}

1;

=head1 NAME

EmpireX::Flickr

=head1 DESCRIPTION

Get Flickr content

=head1 METHODS

=head2 login

=head2 photosets

=head2 photos

=head2 photo_sizes

=head2 photo_info

=cut
