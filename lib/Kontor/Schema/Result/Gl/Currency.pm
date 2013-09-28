use utf8;
package Kontor::Schema::Result::Gl::Currency;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Kontor::Schema::Result::Gl::Currency

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 TABLE: C<gl.currencies>

=cut

__PACKAGE__->table("gl.currencies");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'gl.currencies_id_seq'

=head2 alpha3

  data_type: 'char'
  is_nullable: 1
  size: 3

=head2 country_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 name

  data_type: 'text'
  is_nullable: 1

=head2 decimals

  data_type: 'integer'
  is_nullable: 1

=head2 decimal_point

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 thousand_sep

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 created

  data_type: 'timestamp with time zone'
  default_value: current_timestamp
  is_nullable: 1
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
    sequence          => "gl.currencies_id_seq",
  },
  "alpha3",
  { data_type => "char", is_nullable => 1, size => 3 },
  "country_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "name",
  { data_type => "text", is_nullable => 1 },
  "decimals",
  { data_type => "integer", is_nullable => 1 },
  "decimal_point",
  { data_type => "char", is_nullable => 1, size => 1 },
  "thousand_sep",
  { data_type => "char", is_nullable => 1, size => 1 },
  "created",
  {
    data_type     => "timestamp with time zone",
    default_value => \"current_timestamp",
    is_nullable   => 1,
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
  { "foreign.currency_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 batches

Type: has_many

Related object: L<Kontor::Schema::Result::Gl::Batch>

=cut

__PACKAGE__->has_many(
  "batches",
  "Kontor::Schema::Result::Gl::Batch",
  { "foreign.currency_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 chartofaccounts

Type: has_many

Related object: L<Kontor::Schema::Result::Gl::Chartofaccount>

=cut

__PACKAGE__->has_many(
  "chartofaccounts",
  "Kontor::Schema::Result::Gl::Chartofaccount",
  { "foreign.currency_id" => "self.id" },
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
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 organisations

Type: has_many

Related object: L<Kontor::Schema::Result::Contact::Organisation>

=cut

__PACKAGE__->has_many(
  "organisations",
  "Kontor::Schema::Result::Contact::Organisation",
  { "foreign.currency_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 rates

Type: has_many

Related object: L<Kontor::Schema::Result::Gl::Rate>

=cut

__PACKAGE__->has_many(
  "rates",
  "Kontor::Schema::Result::Gl::Rate",
  { "foreign.currency_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-09-27 23:51:20
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:TrlBCw7oati5f3cFxnMcpQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
