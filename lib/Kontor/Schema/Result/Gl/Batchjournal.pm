package Kontor::Schema::Result::Gl::Batchjournal;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Kontor::Schema::Result::Gl::Batchjournal

=cut

__PACKAGE__->table("gl.batchjournals");

=head1 ACCESSORS

=head2 batch_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 linenr

  data_type: 'integer'
  is_nullable: 0

=head2 accountingdate

  data_type: 'date'
  is_nullable: 1

=head2 description

  data_type: 'text'
  is_nullable: 1

=head2 ag_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 amount

  data_type: 'numeric[]'
  is_nullable: 1

=head2 created

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=head2 modified

  data_type: 'timestamp'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "batch_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "linenr",
  { data_type => "integer", is_nullable => 0 },
  "accountingdate",
  { data_type => "date", is_nullable => 1 },
  "description",
  { data_type => "text", is_nullable => 1 },
  "ag_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "amount",
  { data_type => "numeric[]", is_nullable => 1 },
  "created",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
  "modified",
  { data_type => "timestamp", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("batch_id", "linenr");

=head1 RELATIONS

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

=head2 batch

Type: belongs_to

# Related object: L<Kontor::Schema::Result::Gl::Batch>

=cut

__PACKAGE__->belongs_to(
  "batch",
  "Kontor::Schema::Result::Gl::Batch",
  { id => "batch_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-01-02 20:15:54
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:T9EijeZPqkbNqdWjDwYcGw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
