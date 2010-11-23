package Kontor::Schema::ResultSet::Gl::Getdimensions;

use strict;
use warnings;

use base qw/DBIx::Class::ResultSet/;

sub dimensions {
	my ( $self, $acctstring) = @_;

	my $schema = $self->result_source->schema;

	return $self->search( undef, { bind => [ $acctstring, 1 ] } )->single->dims;
	# return $self->search( undef, { bind => [ $acctstring, $schema->shop->id ] } )->single->dims;
}

1;
