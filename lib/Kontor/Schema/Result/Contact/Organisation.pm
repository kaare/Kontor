use utf8;
package Kontor::Schema::Result::Contact::Organisation;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Kontor::Schema::Result::Contact::Organisation

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 TABLE: C<contact.organisations>

=cut

__PACKAGE__->table("contact.organisations");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'contact.organisations_id_seq'

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
    sequence          => "contact.organisations_id_seq",
  },
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

=head1 RELATIONS

=head2 acctgrids

Type: has_many

Related object: L<Kontor::Schema::Result::Gl::Acctgrid>

=cut

__PACKAGE__->has_many(
  "acctgrids",
  "Kontor::Schema::Result::Gl::Acctgrid",
  { "foreign.org_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 batches

Type: has_many

Related object: L<Kontor::Schema::Result::Gl::Batch>

=cut

__PACKAGE__->has_many(
  "batches",
  "Kontor::Schema::Result::Gl::Batch",
  { "foreign.org_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 chartofaccounts

Type: has_many

Related object: L<Kontor::Schema::Result::Gl::Chartofaccount>

=cut

__PACKAGE__->has_many(
  "chartofaccounts",
  "Kontor::Schema::Result::Gl::Chartofaccount",
  { "foreign.org_id" => "self.id" },
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

=head2 dimensions

Type: has_many

Related object: L<Kontor::Schema::Result::Gl::Dimension>

=cut

__PACKAGE__->has_many(
  "dimensions",
  "Kontor::Schema::Result::Gl::Dimension",
  { "foreign.org_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-09-27 23:50:53
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:25MS7Qk78M5Uys86KXRjJQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
