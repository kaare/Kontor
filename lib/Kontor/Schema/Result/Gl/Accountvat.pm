use utf8;
package Kontor::Schema::Result::Gl::Accountvat;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Kontor::Schema::Result::Gl::Accountvat

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 TABLE: C<gl.accountvat>

=cut

__PACKAGE__->table("gl.accountvat");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'gl.accountvat_id_seq'

=head2 coa_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 vat_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 vat_coa

  data_type: 'integer'
  is_foreign_key: 1
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
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "gl.accountvat_id_seq",
  },
  "coa_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "vat_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "vat_coa",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
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

=head1 RELATIONS

=head2 coa

Type: belongs_to

Related object: L<Kontor::Schema::Result::Gl::Chartofaccount>

=cut

__PACKAGE__->belongs_to(
  "coa",
  "Kontor::Schema::Result::Gl::Chartofaccount",
  { id => "coa_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 vat

Type: belongs_to

Related object: L<Kontor::Schema::Result::Product::Vat>

=cut

__PACKAGE__->belongs_to(
  "vat",
  "Kontor::Schema::Result::Product::Vat",
  { id => "vat_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 vat_coa

Type: belongs_to

Related object: L<Kontor::Schema::Result::Gl::Chartofaccount>

=cut

__PACKAGE__->belongs_to(
  "vat_coa",
  "Kontor::Schema::Result::Gl::Chartofaccount",
  { id => "vat_coa" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-09-27 23:51:20
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:TyrbOOZJjcEEdKeMoH11iQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
