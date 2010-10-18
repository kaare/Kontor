package Kontor::Schema::Result::Gl::Journal;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Kontor::Schema::Result::Gl::Journal

=cut

__PACKAGE__->table("gl.journals");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'gl.journals_id_seq'

=head2 batch_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 journalnr

  data_type: 'integer'
  is_nullable: 0

=head2 ag_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 dr_amount

  data_type: 'numeric'
  is_nullable: 1

=head2 cr_amount

  data_type: 'numeric'
  is_nullable: 1

=head2 description

  data_type: 'text'
  is_nullable: 1

=head2 accountingdate

  data_type: 'date'
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
    sequence          => "gl.journals_id_seq",
  },
  "batch_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "journalnr",
  { data_type => "integer", is_nullable => 0 },
  "ag_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "dr_amount",
  { data_type => "numeric", is_nullable => 1 },
  "cr_amount",
  { data_type => "numeric", is_nullable => 1 },
  "description",
  { data_type => "text", is_nullable => 1 },
  "accountingdate",
  { data_type => "date", is_nullable => 1 },
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

=head1 RELATIONS

=head2 batch

Type: belongs_to

Related object: L<Kontor::Schema::Result::Gl::Batch>

=cut

__PACKAGE__->belongs_to(
  "batch",
  "Kontor::Schema::Result::Gl::Batch",
  { id => "batch_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 ag

Type: belongs_to

Related object: L<Kontor::Schema::Result::Gl::Acctgrid>

=cut

__PACKAGE__->belongs_to(
  "ag",
  "Kontor::Schema::Result::Gl::Acctgrid",
  { id => "ag_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-10-16 14:50:02
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:NL5+1mZbgDf8suW3Lxu7cw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
