use utf8;
package Kontor::Schema::Result::Gl::Accountsoa;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Kontor::Schema::Result::Gl::Accountsoa

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 TABLE: C<gl.accountsoas>

=cut

__PACKAGE__->table("gl.accountsoas");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'gl.accountsoas_id_seq'

=head2 coa_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 type

  data_type: 'gl.accountsoatypes'
  is_nullable: 1
  size: 4

=head2 created

  data_type: 'timestamp with time zone'
  default_value: current_timestamp
  is_nullable: 0
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
    sequence          => "gl.accountsoas_id_seq",
  },
  "coa_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "type",
  { data_type => "gl.accountsoatypes", is_nullable => 1, size => 4 },
  "created",
  {
    data_type     => "timestamp with time zone",
    default_value => \"current_timestamp",
    is_nullable   => 0,
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

=head2 batches

Type: has_many

Related object: L<Kontor::Schema::Result::Gl::Batch>

=cut

__PACKAGE__->has_many(
  "batches",
  "Kontor::Schema::Result::Gl::Batch",
  { "foreign.soa_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 coa

Type: belongs_to

Related object: L<Kontor::Schema::Result::Gl::Chartofaccount>

=cut

__PACKAGE__->belongs_to(
  "coa",
  "Kontor::Schema::Result::Gl::Chartofaccount",
  { id => "coa_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-09-27 23:51:20
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:IJcmnfOdJEpN0J/0xCSOfg

=head1 METHODS

=head2 balance

Find or create the related balance row

=cut

sub balance {
	my ($self, $args) = @_;
	my $schema = $self->result_source->schema;
	my $coa = $self->coa;
	my $dims = $schema->resultset('Gl::Getdimensions')->dimensions($coa->account_nr);
	my $rowdata = {
		org_id => $schema->org_id,
		dim => {-value => $dims},
		currency_id => $schema->currency_id,
	};
	my $ag = $schema->resultset('Gl::Acctgrid')->find($rowdata);
	$rowdata->{dim} = $dims;
	$ag = $schema->resultset('Gl::Acctgrid')->create($rowdata) unless $ag;
	return $ag->find_or_create_related('balances', {periodnr => $args->{periodnr}});##
}

__PACKAGE__->meta->make_immutable;
1;
