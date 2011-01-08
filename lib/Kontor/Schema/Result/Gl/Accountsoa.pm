package Kontor::Schema::Result::Gl::Accountsoa;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Kontor::Schema::Result::Gl::Accountsoa

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
    sequence          => "gl.accountsoas_id_seq",
  },
  "coa_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
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
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

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


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-10-16 14:50:02
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:yfoOUezVSYfDRrBFPeQk8w

use 5.010;

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
	return $ag->find_or_create_related('balances',{periodnr => '2010-12-01'});##
}

1;
