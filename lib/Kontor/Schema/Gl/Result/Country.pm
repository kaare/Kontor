package Kontor::Schema::Gl::Result::Country;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Kontor::Schema::Gl::Result::Country

=cut

__PACKAGE__->table("countries");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'gl.countries_id_seq'

=head2 country_id

  data_type: 'integer'
  is_nullable: 1

=head2 sales_vat

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 sales

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 debitor

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 vat_id

  data_type: 'integer'
  is_nullable: 1

=head2 currency_id

  data_type: 'integer'
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
    sequence          => "gl.countries_id_seq",
  },
  "country_id",
  { data_type => "integer", is_nullable => 1 },
  "sales_vat",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "sales",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "debitor",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "vat_id",
  { data_type => "integer", is_nullable => 1 },
  "currency_id",
  { data_type => "integer", is_nullable => 1 },
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

=head2 sales_vat

Type: belongs_to

Related object: L<Kontor::Schema::Gl::Result::Chartofaccount>

=cut

__PACKAGE__->belongs_to(
  "sales_vat",
  "Kontor::Schema::Gl::Result::Chartofaccount",
  { id => "sales_vat" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 debitor

Type: belongs_to

Related object: L<Kontor::Schema::Gl::Result::Chartofaccount>

=cut

__PACKAGE__->belongs_to(
  "debitor",
  "Kontor::Schema::Gl::Result::Chartofaccount",
  { id => "debitor" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 sale

Type: belongs_to

Related object: L<Kontor::Schema::Gl::Result::Chartofaccount>

=cut

__PACKAGE__->belongs_to(
  "sale",
  "Kontor::Schema::Gl::Result::Chartofaccount",
  { id => "sales" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-10-16 14:50:02
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:21hYB6eCe0AogzHyypTkjg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
