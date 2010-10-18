package Kontor::Schema::Result::Product::Vat;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Kontor::Schema::Result::Product::Vat

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

  data_type: 'timestamp'
  is_nullable: 1

=head2 end_time

  data_type: 'timestamp'
  is_nullable: 1

=head2 country_id

  data_type: 'integer'
  is_nullable: 1

=head2 sv_coa

  data_type: 'integer'
  is_nullable: 1

=head2 pv_coa

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
    sequence          => "product.vats_id_seq",
  },
  "label",
  { data_type => "text", is_nullable => 1 },
  "rate",
  { data_type => "numeric", is_nullable => 1, size => [5, 2] },
  "start_time",
  { data_type => "timestamp", is_nullable => 1 },
  "end_time",
  { data_type => "timestamp", is_nullable => 1 },
  "country_id",
  { data_type => "integer", is_nullable => 1 },
  "sv_coa",
  { data_type => "integer", is_nullable => 1 },
  "pv_coa",
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


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-10-16 14:50:00
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:fBOrQ9mgOhS5CVVFPHmZ9A


# You can replace this text with custom content, and it will be preserved on regeneration
1;
