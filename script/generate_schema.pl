#!/usr/bin/env perl

use Modern::Perl;
use DBIx::Class::Schema::Loader 'make_schema_at';

print $DBIx::Class::Schema::Loader::VERSION;
my @dsn = qw/ dbi:mysql:dbname=nempire /;

my $options = {
    debug          => 1,
    dump_directory => 'lib',
    components     => [qw/ InflateColumn::DateTime /],
};

make_schema_at( 'Nempire::Schema', $options, \@dsn );

=head1 NAME

generate_dbic_schema.pl

=head1 USAGE

perl generate_dbic_schema.pl

=cut

