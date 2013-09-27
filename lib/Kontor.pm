package Kontor;

use 5.010;
use Moose;
use Config::Any;
use Kontor::Model;
use Config::Any;

use Data::Dumper;

has config => (
	isa => 'HashRef',
	is => 'rw',
);

extends 'Mojolicious';

sub startup {
	my $self = shift;

	# Config
	my $config = $self->config;
	$self->helper(config => sub { return $config });
	# Model
	my $model = Kontor::Model->new({
		connect_info => $config->{connect_info},
		org_id => $config->{organisation},
		currency_id => $config->{currency},
	});
	$schema->org_id(1);
	$schema->currency_id(208);
	$self->helper(model => sub { return $model });

	# Plugins
	$self->plugin('xslate_renderer');

	# Routes
	my $r = $self->routes;

	# General Ledger
	$r->route('/gl')->to('gl#index');
	$r->route('/gl/coa/lookup')->to('gl#coa_lookup');
	$r->route('/gl/daybook')->to('gl#daybook');
	$r->route('/gl/daybook/:id')->to('gl#daybook', id => 1);

	# Default route
	$r->route('/:controller/:action/:id')->to('example#welcome', id => 1);
}

sub config {
	my $confname = lc(__PACKAGE__) . '.conf';
	my $config = Config::Any->load_files( { files => [$confname], use_ext => 1 } );
	return $config->[0]->{$confname};
}

1;
# ABSTRACT: Office accounting
