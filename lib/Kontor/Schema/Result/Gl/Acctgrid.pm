use utf8;
package Kontor::Schema::Result::Gl::Acctgrid;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Kontor::Schema::Result::Gl::Acctgrid

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 TABLE: C<gl.acctgrid>

=cut

__PACKAGE__->table("gl.acctgrid");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'gl.acctgrid_id_seq'

=head2 org_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 dim

  data_type: 'integer[]'
  is_nullable: 1

=head2 currency_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 created

  data_type: 'timestamp with time zone'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=head2 modified

  data_type: 'timestamp with time zone'
  is_nullable: 1

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
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "dim",
  { data_type => "integer[]", is_nullable => 1 },
  "currency_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "created",
  {
    data_type     => "timestamp with time zone",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
  "modified",
  { data_type => "timestamp with time zone", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<acctgrid_org_id_dim_key>

=over 4

=item * L</org_id>

=item * L</dim>

=back

=cut

__PACKAGE__->add_unique_constraint("acctgrid_org_id_dim_key", ["org_id", "dim"]);

=head1 RELATIONS

=head2 balances

Type: has_many

Related object: L<Kontor::Schema::Result::Gl::Balance>

=cut

__PACKAGE__->has_many(
  "balances",
  "Kontor::Schema::Result::Gl::Balance",
  { "foreign.ag_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 batchjournals

Type: has_many

Related object: L<Kontor::Schema::Result::Gl::Batchjournal>

=cut

__PACKAGE__->has_many(
  "batchjournals",
  "Kontor::Schema::Result::Gl::Batchjournal",
  { "foreign.ag_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 currency

Type: belongs_to

Related object: L<Kontor::Schema::Result::Gl::Currency>

=cut

__PACKAGE__->belongs_to(
  "currency",
  "Kontor::Schema::Result::Gl::Currency",
  { id => "currency_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 journals

Type: has_many

Related object: L<Kontor::Schema::Result::Gl::Journal>

=cut

__PACKAGE__->has_many(
  "journals",
  "Kontor::Schema::Result::Gl::Journal",
  { "foreign.ag_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 org

Type: belongs_to

Related object: L<Kontor::Schema::Result::Contact::Organisation>

=cut

__PACKAGE__->belongs_to(
  "org",
  "Kontor::Schema::Result::Contact::Organisation",
  { id => "org_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-09-27 23:51:20
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:g2Nw0JJH++VzFIQEKeftAg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
