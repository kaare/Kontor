package Kontor::Schema::Gl::Result::Acctgrid;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Kontor::Schema::Gl::Result::Acctgrid

=cut

__PACKAGE__->table("acctgrid");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'gl.acctgrid_id_seq'

=head2 org_id

  data_type: 'integer'
  is_nullable: 0

=head2 dim

  data_type: 'integer[]'
  is_nullable: 1

=head2 currency_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

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
    sequence          => "gl.acctgrid_id_seq",
  },
  "org_id",
  { data_type => "integer", is_nullable => 0 },
  "dim",
  { data_type => "integer[]", is_nullable => 1 },
  "currency_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
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

=head2 currency

Type: belongs_to

Related object: L<Kontor::Schema::Gl::Result::Currency>

=cut

__PACKAGE__->belongs_to(
  "currency",
  "Kontor::Schema::Gl::Result::Currency",
  { id => "currency_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 balances

Type: has_many

Related object: L<Kontor::Schema::Gl::Result::Balance>

=cut

__PACKAGE__->has_many(
  "balances",
  "Kontor::Schema::Gl::Result::Balance",
  { "foreign.ag_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 batchjournals

Type: has_many

Related object: L<Kontor::Schema::Gl::Result::Batchjournal>

=cut

__PACKAGE__->has_many(
  "batchjournals",
  "Kontor::Schema::Gl::Result::Batchjournal",
  { "foreign.ag_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 journals

Type: has_many

Related object: L<Kontor::Schema::Gl::Result::Journal>

=cut

__PACKAGE__->has_many(
  "journals",
  "Kontor::Schema::Gl::Result::Journal",
  { "foreign.ag_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-10-16 14:50:02
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:IE68TRz5GQMMeMmLXz+KDQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
