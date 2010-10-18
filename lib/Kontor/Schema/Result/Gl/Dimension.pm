package Kontor::Schema::Result::Gl::Dimension;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Kontor::Schema::Result::Gl::Dimension

=cut

__PACKAGE__->table("gl.dimensions");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'gl.dimensions_id_seq'

=head2 org_id

  data_type: 'integer'
  is_nullable: 0

=head2 dimension

  data_type: 'integer'
  is_nullable: 1

=head2 dimtable

  data_type: 'text'
  is_nullable: 1

=head2 dimcolumn

  data_type: 'text'
  is_nullable: 1

=head2 created

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=head2 modified

  data_type: 'timestamp'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "gl.dimensions_id_seq",
  },
  "org_id",
  { data_type => "integer", is_nullable => 0 },
  "dimension",
  { data_type => "integer", is_nullable => 1 },
  "dimtable",
  { data_type => "text", is_nullable => 1 },
  "dimcolumn",
  { data_type => "text", is_nullable => 1 },
  "created",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
  "modified",
  { data_type => "timestamp", is_nullable => 0 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-10-16 14:50:02
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:CJ+rYg/Z6fShur4dlQ/8RQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
