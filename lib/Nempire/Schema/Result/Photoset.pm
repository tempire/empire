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
  { data_type => "char", is_nullable => 1, size => 20 },
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
  { "foreign.photoset_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-03-12 19:43:43
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:flkgHh0vgK37nzWEZa3Xxg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
