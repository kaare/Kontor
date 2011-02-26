package Kontor;

use 5.010;
use Moose;
use Config::Any;
use Kontor::Model;

use Data::Dumper;

has config => (
	isa => 'HashRef',
	is => 'rw',
);

extends 'Mojolicious';

sub startup {
	my $self = shift;

	$self->_config;
	# Model
	my $schema = Kontor::Schema->connect(@{ $self->config->{connect_info} });
	$schema->org_id(1);
	$schema->currency_id(208);
	$self->helper(model => sub { return $schema });

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

sub _config {
	my $self = shift;
	my $confname = lc(__PACKAGE__) . '.conf';
	my $config_total = Config::Any->load_files( { files => [$confname], use_ext => 1 } );
	my $config = $config_total->[0]->{$confname};
	$self->config($config);
}

1;
# ABSTRACT: Office accounting
