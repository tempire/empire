package Nempire::Schema::Result::BlogTag;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Nempire::Schema::Result::BlogTag

=cut

__PACKAGE__->table("blog_tags");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'char'
  is_nullable: 0
  size: 50

=head2 blog

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "char", is_nullable => 0, size => 50 },
  "blog",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 blog

Type: belongs_to

Related object: L<Nempire::Schema::Result::Blog>

=cut

__PACKAGE__->belongs_to(
  "blog",
  "Nempire::Schema::Result::Blog",
  { id => "blog" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-04-05 22:48:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Efiu1vJ4fT8b7OIssZxKVA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
