package Kontor::Schema::Result::Gl::Batch;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Kontor::Schema::Result::Gl::Batch

=cut

__PACKAGE__->table("gl.batches");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'gl.batches_id_seq'

=head2 org_id

  data_type: 'integer'
  is_nullable: 0

=head2 currency_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 system

  data_type: 'gl.systemtype'
  is_nullable: 1
  size: 4

=head2 batchnr

  data_type: 'integer'
  is_nullable: 1

=head2 name

  data_type: 'text'
  is_nullable: 1

=head2 status

  data_type: 'gl.batchstates'
  is_nullable: 1
  size: 4

=head2 totaldr

  data_type: 'numeric'
  default_value: 0
  is_nullable: 1

=head2 totalcr

  data_type: 'numeric'
  default_value: 0
  is_nullable: 1

=head2 postingdate

  data_type: 'date'
  default_value: current_timestamp
  is_nullable: 1
  original: {default_value => \"now()"}

=head2 soa_id

  data_type: 'integer'
  is_foreign_key: 1
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
    sequence          => "gl.batches_id_seq",
  },
  "org_id",
  { data_type => "integer", is_nullable => 0 },
  "currency_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "system",
  { data_type => "gl.systemtype", is_nullable => 1, size => 4 },
  "batchnr",
  { data_type => "integer", is_nullable => 1 },
  "name",
  { data_type => "text", is_nullable => 1 },
  "status",
  { data_type => "gl.batchstates", is_nullable => 1, size => 4 },
  "totaldr",
  { data_type => "numeric", default_value => 0, is_nullable => 1 },
  "totalcr",
  { data_type => "numeric", default_value => 0, is_nullable => 1 },
  "postingdate",
  {
    data_type     => "date",
    default_value => \"current_timestamp",
    is_nullable   => 1,
    original      => { default_value => \"now()" },
  },
  "soa_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
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

=head2 soa

Type: belongs_to

Related object: L<Kontor::Schema::Result::Gl::Accountsoa>

=cut

__PACKAGE__->belongs_to(
  "soa",
  "Kontor::Schema::Result::Gl::Accountsoa",
  { id => "soa_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 currency

Type: belongs_to

Related object: L<Kontor::Schema::Result::Gl::Currency>

=cut

__PACKAGE__->belongs_to(
  "currency",
  "Kontor::Schema::Result::Gl::Currency",
  { id => "currency_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 batchjournals

Type: has_many

Related object: L<Kontor::Schema::Result::Gl::Batchjournal>

=cut

__PACKAGE__->has_many(
  "batchjournals",
  "Kontor::Schema::Result::Gl::Batchjournal",
  { "foreign.batch_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 journals

Type: has_many

Related object: L<Kontor::Schema::Result::Gl::Journal>

=cut

__PACKAGE__->has_many(
  "journals",
  "Kontor::Schema::Result::Gl::Journal",
  { "foreign.batch_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-10-16 14:50:02
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:OU1MgTHIS95h98GO+qHxjA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
