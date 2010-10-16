package Kontor::Schema::Gl::Result::Rate;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Kontor::Schema::Gl::Result::Rate

=cut

__PACKAGE__->table("rates");

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

  data_type: 'activestate'
  is_nullable: 1
  size: 4

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

  data_type: 'timestamp'
  default_value: -infinity
  is_nullable: 1

=head2 end_time

  data_type: 'timestamp'
  default_value: infinity
  is_nullable: 1

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
    sequence          => "gl.rates_id_seq",
  },
  "label",
  { data_type => "text", default_value => "", is_nullable => 1 },
  "ratestate",
  { data_type => "activestate", is_nullable => 1, size => 4 },
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
    data_type     => "timestamp",
    default_value => "-infinity",
    is_nullable   => 1,
  },
  "end_time",
  { data_type => "timestamp", default_value => "infinity", is_nullable => 1 },
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

=head2 currency

Type: belongs_to

Related object: L<Kontor::Schema::Gl::Result::Currency>

=cut

__PACKAGE__->belongs_to(
  "currency",
  "Kontor::Schema::Gl::Result::Currency",
  { id => "currency_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-10-16 14:50:02
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:S7K9UrEArfMOWhvkCGnfLw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
