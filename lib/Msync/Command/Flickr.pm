package Msync::Command::Flickr;

use Msync -command;

use Modern::Perl;
use EmpireX::Flickr;
use Devel::Dwarn;

sub opt_spec {
    return (
        ['set|s=s'     => 'Photoset name or id'],
        ['sets-only|o' => 'Just sync photoset index'],
        ['photo|p=s'   => 'Photo id'],
        ['all|a'       => 'Sync everything']
    );
}

sub abstract   {'Sync Flickr photos'}
sub usage_desc {'msync flickr --all'}

sub validate_args {
    my ($self, $opt, $args) = @_;

    $self->usage_error('Action not specified')
      if !$opt->set
          and !$opt->photo
          and !$opt->all;
}

sub execute {
    my ($self, $opt, $args) = @_;
    my $parameter = $opt->set;
    my $subtype = 'photosets' if $opt->sets_only;

    my $schema = $self->app->schema;

    my $f = EmpireX::Flickr->new->login;

    my $i = 0;
    foreach my $set (reverse $f->photosets) {
        $i++;

        next
          if $parameter
              and ($parameter ne $set->{id} and $parameter ne $set->{title});

        $set->{primary_photo} = $set->{primary};
        $set->{idx}           = $i;

        delete $set->{primary};
        print "$set->{title}\n";

        my $photoset =
          $schema->resultset('Photoset')->update_or_create($set);

        #my $riak = $self->app->riak;
        #my $rphotoset =
        #  $riak->bucket('photosets')->new_object($set->{id} => $set)->store;

        next if $subtype and $subtype eq "photosets";

        $photoset = $schema->resultset('Photoset')->find($set->{id});

        print "Getting photos for $set->{title} ($set->{id})...";
        my @photos = $f->photos($set->{id});
        print @photos . "\n";

        my $i = 0;
        foreach (@photos) {
            my %info  = $f->photo_info($_->{id});
            my %sizes = $f->photo_sizes($_->{id});

            foreach (keys %sizes) {
                $info{$_} = $sizes{$_};
            }
            delete $info{large};
            delete $info{'medium 640'};

            $info{idx} = ++$i;

            printf "%0" . length(scalar @photos) . "d", $i;
            print "\b" x length(scalar @photos);

            #$riak->bucket('photos')->new_object($info->{id} => $info)
            #  ->store
            #  ->add_link($rphotoset => 'set');
            $photoset->photos->update_or_create(\%info);
        }
        print "\n";
    }
}

1;
