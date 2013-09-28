use utf8;
package Kontor::Schema::Result::Gl::Batchjournal;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Kontor::Schema::Result::Gl::Batchjournal

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 TABLE: C<gl.batchjournals>

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

  data_type: 'timestamp with time zone'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=head2 modified

  data_type: 'timestamp with time zone'
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

=item * L</batch_id>

=item * L</linenr>

=back

=cut

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
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 batch

Type: belongs_to

Related object: L<Kontor::Schema::Result::Gl::Batch>

=cut

__PACKAGE__->belongs_to(
  "batch",
  "Kontor::Schema::Result::Gl::Batch",
  { id => "batch_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-09-27 23:51:20
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:khwcTz9lodM/Z53XwT6wpQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
