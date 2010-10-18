package Kontor::Schema::Result::Gl::Currency;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Kontor::Schema::Result::Gl::Currency

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

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 1
  original: {default_value => \"now()"}

=head2 modified

  data_type: 'timestamp'
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
  { data_type => "integer", is_nullable => 0 },
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
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 1,
    original      => { default_value => \"now()" },
  },
  "modified",
  { data_type => "timestamp", is_nullable => 1 },
);
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


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-10-16 14:50:02
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Jz9R3mY/t5rdFfTz9G89EQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
