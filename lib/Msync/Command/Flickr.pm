package Msync::Command::Flickr;

use Msync -command;

use Devel::Dwarn;
use EmpireX::Flickr;
use Modern::Perl;
#use Parallel::ForkManager;

sub opt_spec {
    return (
        ['set|s=s'     => 'Photoset name or id'],
        ['sets-only|o' => 'Just sync photoset index'],
        ['photo|p=s'   => 'Photo id'],
        ['all|a'       => 'Sync everything'],
        [   'max-children|m=i' => 'Max children to fork. Defaults to 10',
            {default => 10}
        ],
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
    my $subtype; $subtype = 'photosets' if $opt->sets_only;

    my $schema = $self->app->schema;

    $|++;

    my $f  = EmpireX::Flickr->new->login;
    #my $pm = Parallel::ForkManager->new($opt->max_children);

    my @txns;

    my $i = 0;
    foreach my $set (reverse $f->photosets) {
        #my $pid = $pm->start and next;

        $i++;

        next
          if $parameter
              and
              ($parameter ne $set->{id} and $parameter ne $set->{title});

        my $txn = sub {

            $set->{primary_photo} = $set->{primary};
            $set->{idx}           = $i;

            delete $set->{primary};

            #warn Dwarn $set;
            my $photoset =
              $schema->resultset('Photoset')->update_or_create($set);

         #my $riak = $self->app->riak;
         #my $rphotoset =
         #  $riak->bucket('photosets')->new_object($set->{id} => $set)->store;

            next if $subtype and $subtype eq "photosets";

            $photoset = $schema->resultset('Photoset')->find($set->{id});

            print "$set->{title} ($set->{id})...";
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

                print ".";

                #printf "%0" . length(scalar @photos) . "d", $i;
                #print "\b" x length(scalar @photos);

                #$riak->bucket('photos')->new_object($info->{id} => $info)
                #  ->store
                #  ->add_link($rphotoset => 'set');
                $photoset->photos->update_or_create(\%info);
            }

        };
        $schema->txn_do($txn);

        #$pm->finish;

        print "\n";
    }
}

1;
