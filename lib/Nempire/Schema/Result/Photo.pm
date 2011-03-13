package Nempire::Schema::Result::Photo;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Nempire::Schema::Result::Photo

=cut

__PACKAGE__->table("photos");

=head1 ACCESSORS

=head2 id

  data_type: 'char'
  default_value: (empty string)
  is_nullable: 0
  size: 20

=head2 description

  data_type: 'char'
  is_nullable: 1
  size: 255

=head2 lat

  data_type: 'char'
  is_nullable: 1
  size: 10

=head2 lon

  data_type: 'char'
  is_nullable: 1
  size: 10

=head2 region

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 locality

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 country

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 square

  data_type: 'tinytext'
  is_nullable: 1

=head2 original_url

  data_type: 'tinytext'
  is_nullable: 1

=head2 taken

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 isprimary

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 small

  data_type: 'tinytext'
  is_nullable: 1

=head2 medium

  data_type: 'tinytext'
  is_nullable: 1

=head2 original

  data_type: 'tinytext'
  is_nullable: 1

=head2 thumbnail

  data_type: 'tinytext'
  is_nullable: 1

=head2 large

  data_type: 'tinytext'
  is_nullable: 1

=head2 is_glen

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 idx

  data_type: 'integer'
  is_nullable: 1

=head2 photoset_id

  data_type: 'char'
  is_foreign_key: 1
  is_nullable: 1
  size: 20

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "char", default_value => "", is_nullable => 0, size => 20 },
  "description",
  { data_type => "char", is_nullable => 1, size => 255 },
  "lat",
  { data_type => "char", is_nullable => 1, size => 10 },
  "lon",
  { data_type => "char", is_nullable => 1, size => 10 },
  "region",
  { data_type => "char", is_nullable => 1, size => 20 },
  "locality",
  { data_type => "char", is_nullable => 1, size => 20 },
  "country",
  { data_type => "char", is_nullable => 1, size => 20 },
  "square",
  { data_type => "tinytext", is_nullable => 1 },
  "original_url",
  { data_type => "tinytext", is_nullable => 1 },
  "taken",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "isprimary",
  { data_type => "char", is_nullable => 1, size => 1 },
  "small",
  { data_type => "tinytext", is_nullable => 1 },
  "medium",
  { data_type => "tinytext", is_nullable => 1 },
  "original",
  { data_type => "tinytext", is_nullable => 1 },
  "thumbnail",
  { data_type => "tinytext", is_nullable => 1 },
  "large",
  { data_type => "tinytext", is_nullable => 1 },
  "is_glen",
  { data_type => "char", is_nullable => 1, size => 1 },
  "idx",
  { data_type => "integer", is_nullable => 1 },
  "photoset_id",
  { data_type => "char", is_foreign_key => 1, is_nullable => 1, size => 20 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 photoset

Type: belongs_to

Related object: L<Nempire::Schema::Result::Photoset>

=cut

__PACKAGE__->belongs_to(
  "photoset",
  "Nempire::Schema::Result::Photoset",
  { id => "photoset_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-03-12 18:18:25
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:He0FHsXszdiPhAWsx3z/uw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
