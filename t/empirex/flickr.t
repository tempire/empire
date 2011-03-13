use Modern::Perl;
use EmpireX::Flickr;
use Devel::Dwarn;

use Test::Most;

my $f = EmpireX::Flickr->new;

ok $f->login;
ok $f->echo;

# Photoset list
ok my @sets = $f->photosets;
cmp_ok @sets, '>', 10;
ok $sets[0]->{id};
isnt ref $sets[0]->{title}      => 'hash';
isnt ref $sets[0]->{descrption} => 'hash';

# Photo list
ok my @photos = $f->photos($sets[0]->{id});
cmp_ok @photos, '>', 10;
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