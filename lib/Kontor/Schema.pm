package Kontor::Schema;

# Created by DBIx::Class::Schema::Loader

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'DBIx::Class::Schema';

my @namespaces =  qw /Contact Gl Product/ ;
__PACKAGE__->load_namespaces(
	result_namespace    => [ map {$_.'::Result'} @namespaces ],
	resultset_namespace => [ map {$_.'::ResultSet'} @namespaces ],
);

__PACKAGE__->meta->make_immutable;
1;
