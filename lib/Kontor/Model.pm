package Kontor::Model;

use 5.010;
use strict;
use warnings;
use Kontor::Schema;
use Moose;
use MooseX::ClassAttribute;

class_has 'schema' => (
	is      => 'rw',
	isa     => 'Kontor::Schema',
);
has 'org_id' => (
	isa => 'Int',
	is => 'rw',
);
has 'currency_id' => (
	isa => 'Int',
	is => 'rw',
);

sub BUILD {
	my $self = shift;
	my $schema = $self->schema;
	$schema->org_id($self->org_id);
	$schema->currency_id($self->currency_id);
};

__PACKAGE__->meta()->make_immutable();

no Moose;
no MooseX::ClassAttribute;

Kontor::Model->schema(Kontor::Schema->connect('dbi:Pg:dbname=kontor'));

1;
