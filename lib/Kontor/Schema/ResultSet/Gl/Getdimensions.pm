package Kontor::Schema::ResultSet::Gl::Getdimensions;

use strict;
use warnings;

use base qw/DBIx::Class::ResultSet/;

sub dimensions {
	my ( $self, $acctstring) = @_;
	my $schema = $self->result_source->schema;
	return $self->search( undef, { bind => [ $acctstring, $schema->org_id ] } )->single->dims;
}

1;
