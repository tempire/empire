package Nempire::Schema::Result::Blog;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Nempire::Schema::Result::Blog

=cut

__PACKAGE__->table("blogs");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 title

  data_type: 'char'
  is_nullable: 0
  size: 100

=head2 subtitle

  data_type: 'tinytext'
  is_nullable: 1

=head2 content

  data_type: 'text'
  is_nullable: 0

=head2 created_time

  data_type: 'char'
  is_nullable: 0
  size: 20

=head2 timestamp

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=head2 location

  data_type: 'char'
  is_nullable: 1
  size: 100

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "title",
  { data_type => "char", is_nullable => 0, size => 100 },
  "subtitle",
  { data_type => "tinytext", is_nullable => 1 },
  "content",
  { data_type => "text", is_nullable => 0 },
  "created_time",
  { data_type => "char", is_nullable => 0, size => 20 },
  "timestamp",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
  "location",
  { data_type => "char", is_nullable => 1, size => 100 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-03-12 17:18:43
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:w4UQU7Iom/1XoohaOGyVxw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
