use utf8;
package Kontor::Schema::Result::Contact::Country;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Kontor::Schema::Result::Contact::Country

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 TABLE: C<contact.countries>

=cut

__PACKAGE__->table("contact.countries");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'contact.countries_id_seq'

=head2 alpha2

  data_type: 'varchar'
  is_nullable: 1
  size: 2

=head2 alpha3

  data_type: 'varchar'
  is_nullable: 1
  size: 3

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

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
    sequence          => "contact.countries_id_seq",
  },
  "alpha2",
  { data_type => "varchar", is_nullable => 1, size => 2 },
  "alpha3",
  { data_type => "varchar", is_nullable => 1, size => 3 },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
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

=head2 C<countries_alpha2_key>

=over 4

=item * L</alpha2>

=back

=cut

__PACKAGE__->add_unique_constraint("countries_alpha2_key", ["alpha2"]);

=head2 C<countries_alpha3_key>

=over 4

=item * L</alpha3>

=back

=cut

__PACKAGE__->add_unique_constraint("countries_alpha3_key", ["alpha3"]);

=head1 RELATIONS

=head2 countries

Type: has_many

Related object: L<Kontor::Schema::Result::Gl::Country>

=cut

__PACKAGE__->has_many(
  "countries",
  "Kontor::Schema::Result::Gl::Country",
  { "foreign.country_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 currencies

Type: has_many

Related object: L<Kontor::Schema::Result::Gl::Currency>

=cut

__PACKAGE__->has_many(
  "currencies",
  "Kontor::Schema::Result::Gl::Currency",
  { "foreign.country_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 vats

Type: has_many

Related object: L<Kontor::Schema::Result::Product::Vat>

=cut

__PACKAGE__->has_many(
  "vats",
  "Kontor::Schema::Result::Product::Vat",
  { "foreign.country_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-09-27 23:50:36
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:vhKrWZd+TbwIRECc5IDnHQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
