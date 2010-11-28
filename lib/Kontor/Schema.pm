package Kontor::Schema;

# Created by DBIx::Class::Schema::Loader

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'DBIx::Class::Schema';

__PACKAGE__->load_namespaces;

has 'org_id' => (
	isa => 'Int',
	is => 'rw',
);
has 'currency_id' => (
	isa => 'Int',
	is => 'rw',
);

__PACKAGE__->meta->make_immutable;

1;
