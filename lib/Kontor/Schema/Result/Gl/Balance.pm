use utf8;
package Kontor::Schema::Result::Gl::Balance;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Kontor::Schema::Result::Gl::Balance

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 TABLE: C<gl.balances>

=cut

__PACKAGE__->table("gl.balances");

=head1 ACCESSORS

=head2 ag_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 periodnr

  data_type: 'date'
  is_nullable: 0

=head2 begindr

  data_type: 'numeric'
  default_value: 0
  is_nullable: 1

=head2 begincr

  data_type: 'numeric'
  default_value: 0
  is_nullable: 1

=head2 perioddr

  data_type: 'numeric'
  default_value: 0
  is_nullable: 1

=head2 periodcr

  data_type: 'numeric'
  default_value: 0
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
  "ag_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "periodnr",
  { data_type => "date", is_nullable => 0 },
  "begindr",
  { data_type => "numeric", default_value => 0, is_nullable => 1 },
  "begincr",
  { data_type => "numeric", default_value => 0, is_nullable => 1 },
  "perioddr",
  { data_type => "numeric", default_value => 0, is_nullable => 1 },
  "periodcr",
  { data_type => "numeric", default_value => 0, is_nullable => 1 },
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

=item * L</ag_id>

=item * L</periodnr>

=back

=cut

__PACKAGE__->set_primary_key("ag_id", "periodnr");

=head1 RELATIONS

=head2 ag

Type: belongs_to

Related object: L<Kontor::Schema::Result::Gl::Acctgrid>

=cut

__PACKAGE__->belongs_to(
  "ag",
  "Kontor::Schema::Result::Gl::Acctgrid",
  { id => "ag_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-09-27 23:51:20
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:tcfb3L9fZ2TAcb3DCx5O3w


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
