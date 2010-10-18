package Kontor::Schema::Result::Gl::Chartofaccount;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Kontor::Schema::Result::Gl::Chartofaccount

=cut

__PACKAGE__->table("gl.chartofaccounts");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'gl.chartofaccounts_id_seq'

=head2 org_id

  data_type: 'integer'
  is_nullable: 0

=head2 name

  data_type: 'text'
  is_nullable: 1

=head2 type

  data_type: 'gl.accounttypes'
  is_nullable: 1
  size: 4

=head2 currency_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 account_nr

  data_type: 'text'
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
    sequence          => "gl.chartofaccounts_id_seq",
  },
  "org_id",
  { data_type => "integer", is_nullable => 0 },
  "name",
  { data_type => "text", is_nullable => 1 },
  "type",
  { data_type => "gl.accounttypes", is_nullable => 1, size => 4 },
  "currency_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "account_nr",
  { data_type => "text", is_nullable => 1 },
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

=head2 accountsoas

Type: has_many

Related object: L<Kontor::Schema::Result::Gl::Accountsoa>

=cut

__PACKAGE__->has_many(
  "accountsoas",
  "Kontor::Schema::Result::Gl::Accountsoa",
  { "foreign.coa_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 accountvat_coas

Type: has_many

Related object: L<Kontor::Schema::Result::Gl::Accountvat>

=cut

__PACKAGE__->has_many(
  "accountvat_coas",
  "Kontor::Schema::Result::Gl::Accountvat",
  { "foreign.coa_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 accountvat_vat_coas

Type: has_many

Related object: L<Kontor::Schema::Result::Gl::Accountvat>

=cut

__PACKAGE__->has_many(
  "accountvat_vat_coas",
  "Kontor::Schema::Result::Gl::Accountvat",
  { "foreign.vat_coa" => "self.id" },
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
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 countries_sales_vats

Type: has_many

Related object: L<Kontor::Schema::Result::Gl::Country>

=cut

__PACKAGE__->has_many(
  "countries_sales_vats",
  "Kontor::Schema::Result::Gl::Country",
  { "foreign.sales_vat" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 countries_debitors

Type: has_many

Related object: L<Kontor::Schema::Result::Gl::Country>

=cut

__PACKAGE__->has_many(
  "countries_debitors",
  "Kontor::Schema::Result::Gl::Country",
  { "foreign.debitor" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 countries_sales

Type: has_many

Related object: L<Kontor::Schema::Result::Gl::Country>

=cut

__PACKAGE__->has_many(
  "countries_sales",
  "Kontor::Schema::Result::Gl::Country",
  { "foreign.sales" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-10-16 14:50:02
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:teLYPKQxyU66qGN486n5zA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
