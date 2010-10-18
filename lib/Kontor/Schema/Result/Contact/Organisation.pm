package Kontor::Schema::Result::Contact::Organisation;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Kontor::Schema::Result::Contact::Organisation

=cut

__PACKAGE__->table("contact.organisations");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'contact.organisations_id_seq'

=head2 currency_id

  data_type: 'integer'
  is_nullable: 0

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
    sequence          => "contact.organisations_id_seq",
  },
  "currency_id",
  { data_type => "integer", is_nullable => 0 },
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


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-10-16 14:47:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:PAdMpkY54/4kBnoEwGyPTQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
