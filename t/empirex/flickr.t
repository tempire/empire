use Modern::Perl;
use Devel::Dwarn;
use Test::Most;
use Mock::Quick;
use EmpireX::Flickr;

ok my $f = EmpireX::Flickr->new;
ok $f->login;
ok $f->echo;

# Photoset list
ok my @sets = $f->photosets;
cmp_ok @sets, '>', 10;
ok $sets[0]->{id};
isnt ref $sets[0]->{title} => 'hash';
ok exists $sets[0]->{description};
isnt ref $sets[0]->{description} => 'hash';

# Photo list
ok my @photos = $f->photos($sets[0]->{id});
cmp_ok @photos, '>', 5;
ok $photos[0]->{title};

# Photo sizes
ok my %sizes = $f->photo_sizes($photos[0]->{id});
is keys %sizes        => 7;
like $sizes{original} => qr|http://.*jpg$|;
like $sizes{medium}   => qr|http://.*jpg$|;
like $sizes{square}   => qr|http://.*jpg$|;

# Photo info
ok my %info = $f->photo_info($photos[0]->{id});
is $info{id}  => $photos[0]->{id};
is keys %info => 8;

done_testing;
