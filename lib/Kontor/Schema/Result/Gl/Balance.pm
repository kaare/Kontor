package Kontor::Schema::Result::Gl::Balance;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Kontor::Schema::Result::Gl::Balance

=cut

__PACKAGE__->table("gl.balances");

=head1 ACCESSORS

=head2 ag_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 periodnr

  data_type: 'date'
  is_nullable: 0

=head2 begindr

  data_type: 'numeric'
  default_value: 0
  is_nullable: 1

=head2 begincr

  data_type: 'numeric'
  default_value: 0
  is_nullable: 1

=head2 perioddr

  data_type: 'numeric'
  default_value: 0
  is_nullable: 1

=head2 periodcr

  data_type: 'numeric'
  default_value: 0
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
  "ag_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "periodnr",
  { data_type => "date", is_nullable => 0 },
  "begindr",
  { data_type => "numeric", default_value => 0, is_nullable => 1 },
  "begincr",
  { data_type => "numeric", default_value => 0, is_nullable => 1 },
  "perioddr",
  { data_type => "numeric", default_value => 0, is_nullable => 1 },
  "periodcr",
  { data_type => "numeric", default_value => 0, is_nullable => 1 },
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
__PACKAGE__->set_primary_key("ag_id", "periodnr");

=head1 RELATIONS

=head2 ag

Type: belongs_to

Related object: L<Kontor::Schema::Result::Gl::Acctgrid>

=cut

__PACKAGE__->belongs_to(
  "ag",
  "Kontor::Schema::Result::Gl::Acctgrid",
  { id => "ag_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-10-16 14:50:02
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:3cxzU7LmIVI2eVPtqTMwxg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
