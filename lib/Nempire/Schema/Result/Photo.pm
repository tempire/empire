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

=head2 photoset

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
  { data_type => "datetime", is_nullable => 1 },
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
  "photoset",
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
  { id => "photoset" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 photosets

Type: has_many

Related object: L<Nempire::Schema::Result::Photoset>

=cut

__PACKAGE__->has_many(
  "photosets",
  "Nempire::Schema::Result::Photoset",
  { "foreign.primary_photo" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-08-28 14:38:05
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:FrgRQmP7d3y1asyBF3P4qw

use Time::Duration;

=head2 set

Type: belongs_to

Related object: L<Nempire::Schema::Result::Photoset>

Alias for L<Nempire::Schema::Result::Photo/photoset>

=cut

__PACKAGE__->belongs_to(
  "set",
  "Nempire::Schema::Result::Photoset",
  { id => "photoset" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

sub location {
  my $self = shift;

  my $location = $self->locality;
  $location .= ', ' if $self->locality and $self->region;
  $location .= $self->region if $self->region;

  return $location;
}

sub next {
    my $self = shift;

    return if !$self->idx;

    return $self->result_source->resultset->find(
        {   photoset => $self->set->id,
            idx      => $self->idx + 1
        }
    );
}

sub previous {
    my $self = shift;

    return if !$self->idx;

    return $self->result_source->resultset->find(
        {   photoset => $self->set->id,
            idx      => $self->idx - 1
        }
    );
}

sub time_since {
    my $self = shift;
    return Time::Duration::ago(time - $self->taken->epoch) if $self->taken;
}

=head1 METHODS

=head2 location

City, State

=head2 previous

Previous photo in set according to idx

=head2 next

Next photo in set according to idx

=head2 time_since

Time since photo was taken

=cut

1;
