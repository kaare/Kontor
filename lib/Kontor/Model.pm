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

__PACKAGE__->meta()->make_immutable();

no Moose;
no MooseX::ClassAttribute;

Kontor::Model->schema(Kontor::Schema->connect('dbi:Pg:dbname=kontor'));

1;
