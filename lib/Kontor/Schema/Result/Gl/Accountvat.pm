package Kontor::Schema::Result::Gl::Accountvat;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Kontor::Schema::Result::Gl::Accountvat

=cut

__PACKAGE__->table("gl.accountvat");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'gl.accountvat_id_seq'

=head2 coa_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 vat_id

  data_type: 'integer'
  is_nullable: 1

=head2 vat_coa

  data_type: 'integer'
  is_foreign_key: 1
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
    sequence          => "gl.accountvat_id_seq",
  },
  "coa_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "vat_id",
  { data_type => "integer", is_nullable => 1 },
  "vat_coa",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
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

=head2 coa

Type: belongs_to

Related object: L<Kontor::Schema::Result::Gl::Chartofaccount>

=cut

__PACKAGE__->belongs_to(
  "coa",
  "Kontor::Schema::Result::Gl::Chartofaccount",
  { id => "coa_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 vat_coa

Type: belongs_to

Related object: L<Kontor::Schema::Result::Gl::Chartofaccount>

=cut

__PACKAGE__->belongs_to(
  "vat_coa",
  "Kontor::Schema::Result::Gl::Chartofaccount",
  { id => "vat_coa" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-10-16 14:50:02
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Ui9rcwjKvKCsqHSBhBnCjA


=head2 vat

Type: belongs_to

Related object: L<Kontor::Schema::Result::Product::Vat>

=cut

__PACKAGE__->belongs_to(
  "vat",
  "Kontor::Schema::Result::Product::Vat",
  { id => "vat_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

# You can replace this text with custom content, and it will be preserved on regeneration
1;
