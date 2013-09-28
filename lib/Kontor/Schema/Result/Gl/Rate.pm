use utf8;
package Kontor::Schema::Result::Gl::Rate;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Kontor::Schema::Result::Gl::Rate

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 TABLE: C<gl.rates>

=cut

__PACKAGE__->table("gl.rates");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'gl.rates_id_seq'

=head2 label

  data_type: 'text'
  default_value: (empty string)
  is_nullable: 1

=head2 ratestate

  data_type: 'enum'
  extra: {custom_type_name => "activestate",list => ["active","inactive"]}
  is_nullable: 1

=head2 rate

  data_type: 'numeric'
  default_value: 1.00
  is_nullable: 1
  size: [10,2]

=head2 currency_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 start_time

  data_type: 'timestamp with time zone'
  default_value: -infinity
  is_nullable: 1

=head2 end_time

  data_type: 'timestamp with time zone'
  default_value: infinity
  is_nullable: 1

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
    sequence          => "gl.rates_id_seq",
  },
  "label",
  { data_type => "text", default_value => "", is_nullable => 1 },
  "ratestate",
  {
    data_type => "enum",
    extra => { custom_type_name => "activestate", list => ["active", "inactive"] },
    is_nullable => 1,
  },
  "rate",
  {
    data_type => "numeric",
    default_value => "1.00",
    is_nullable => 1,
    size => [10, 2],
  },
  "currency_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "start_time",
  {
    data_type     => "timestamp with time zone",
    default_value => "-infinity",
    is_nullable   => 1,
  },
  "end_time",
  {
    data_type     => "timestamp with time zone",
    default_value => "infinity",
    is_nullable   => 1,
  },
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


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-09-27 23:51:20
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:QTwv4VdH+rs6IsdhptWGIw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
