use utf8;
package Kontor::Schema::Result::Product::Vat;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Kontor::Schema::Result::Product::Vat

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 TABLE: C<product.vats>

=cut

__PACKAGE__->table("product.vats");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'product.vats_id_seq'

=head2 label

  data_type: 'text'
  is_nullable: 1

=head2 rate

  data_type: 'numeric'
  is_nullable: 1
  size: [5,2]

=head2 start_time

  data_type: 'timestamp with time zone'
  is_nullable: 1

=head2 end_time

  data_type: 'timestamp with time zone'
  is_nullable: 1

=head2 country_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 sv_coa

  data_type: 'integer'
  is_nullable: 1

=head2 pv_coa

  data_type: 'integer'
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
    sequence          => "product.vats_id_seq",
  },
  "label",
  { data_type => "text", is_nullable => 1 },
  "rate",
  { data_type => "numeric", is_nullable => 1, size => [5, 2] },
  "start_time",
  { data_type => "timestamp with time zone", is_nullable => 1 },
  "end_time",
  { data_type => "timestamp with time zone", is_nullable => 1 },
  "country_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "sv_coa",
  { data_type => "integer", is_nullable => 1 },
  "pv_coa",
  { data_type => "integer", is_nullable => 1 },
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

=head2 accountvats

Type: has_many

Related object: L<Kontor::Schema::Result::Gl::Accountvat>

=cut

__PACKAGE__->has_many(
  "accountvats",
  "Kontor::Schema::Result::Gl::Accountvat",
  { "foreign.vat_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 countries

Type: has_many

Related object: L<Kontor::Schema::Result::Gl::Country>

=cut

__PACKAGE__->has_many(
  "countries",
  "Kontor::Schema::Result::Gl::Country",
  { "foreign.vat_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 country

Type: belongs_to

Related object: L<Kontor::Schema::Result::Contact::Country>

=cut

__PACKAGE__->belongs_to(
  "country",
  "Kontor::Schema::Result::Contact::Country",
  { id => "country_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-09-27 23:51:33
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:6ScsL7OXVdkBoZlE8E3H0Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
