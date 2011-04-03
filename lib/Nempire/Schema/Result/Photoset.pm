package Nempire::Schema::Result::Photoset;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Nempire::Schema::Result::Photoset

=cut

__PACKAGE__->table("photosets");

=head1 ACCESSORS

=head2 id

  data_type: 'char'
  is_nullable: 0
  size: 20

=head2 title

  data_type: 'char'
  is_nullable: 0
  size: 255

=head2 server

  data_type: 'char'
  is_nullable: 0
  size: 10

=head2 farm

  data_type: 'integer'
  is_nullable: 0

=head2 photos

  data_type: 'integer'
  is_nullable: 1

=head2 videos

  data_type: 'integer'
  is_nullable: 1

=head2 secret

  data_type: 'char'
  is_nullable: 0
  size: 20

=head2 primary_photo

  data_type: 'char'
  is_foreign_key: 1
  is_nullable: 1
  size: 20

=head2 idx

  data_type: 'integer'
  is_nullable: 0

=head2 description

  data_type: 'char'
  is_nullable: 0
  size: 255

=head2 timestamp

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "char", is_nullable => 0, size => 20 },
  "title",
  { data_type => "char", is_nullable => 0, size => 255 },
  "server",
  { data_type => "char", is_nullable => 0, size => 10 },
  "farm",
  { data_type => "integer", is_nullable => 0 },
  "photos",
  { data_type => "integer", is_nullable => 1 },
  "videos",
  { data_type => "integer", is_nullable => 1 },
  "secret",
  { data_type => "char", is_nullable => 0, size => 20 },
  "primary_photo",
  { data_type => "char", is_foreign_key => 1, is_nullable => 1, size => 20 },
  "idx",
  { data_type => "integer", is_nullable => 0 },
  "description",
  { data_type => "char", is_nullable => 0, size => 255 },
  "timestamp",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 photos

Type: has_many

Related object: L<Nempire::Schema::Result::Photo>

=cut

__PACKAGE__->has_many(
  "photos",
  "Nempire::Schema::Result::Photo",
  { "foreign.photoset" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 primary_photo

Type: belongs_to

Related object: L<Nempire::Schema::Result::Photo>

=cut

__PACKAGE__->belongs_to(
  "primary_photo",
  "Nempire::Schema::Result::Photo",
  { id => "primary_photo" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-03-12 21:00:40
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:g4aav56iFJy62zsHNTLsGg

use Time::Duration;

=head2 primary

Type: belongs_to

Related object: L<Nempire::Schema::Result::Photo>

Alias for L<Nempire::Schema::Result::Photo/primary_photo>

=cut

__PACKAGE__->belongs_to(
  "primary",
  "Nempire::Schema::Result::Photo",
  { id => "primary_photo" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


sub date   { shift->primary_photo->taken }
sub region { shift->primary_photo->region }

sub url_title {
    my $title = shift->title;

    return lc $title if $title =~ s/[^a-zA-Z0-9]+/_/g;
}

sub previous {
    my $self = shift;
    return $self->result_source->resultset->search({idx => $self->idx - 1})
      ->first;
}

sub next {
    my $self = shift;

    return $self->result_source->resultset->search({idx => $self->idx + 1})
      ->first;
}

sub location {
    return shift->primary->location;
}

sub time_since {
    my $self = shift;
    return Time::Duration::ago(time - $self->date->epoch) if $self->date;
}

1;

=head1 METHODS

=head2 date

Datetime object from set's primary photo

=head2 url_title

Title for use in readable URLs - uses id for incompatible titles

=head2 region

Region from set's primary photo

=head2 previous

Previous set, ordered by idx field

=head2 next

Next set, ordered by idx field

=head2 location

Location from set's primary photo

=head2 time_since

Time since photo was taken

=cut
