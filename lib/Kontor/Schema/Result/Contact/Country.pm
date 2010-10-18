package Kontor::Schema::Result::Contact::Country;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Kontor::Schema::Result::Contact::Country

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
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
  "modified",
  { data_type => "timestamp", is_nullable => 0 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("countries_alpha3_key", ["alpha3"]);
__PACKAGE__->add_unique_constraint("countries_alpha2_key", ["alpha2"]);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-10-16 14:47:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:RZbQg/BLRtHNZ8g84FJilg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
