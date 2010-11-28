package Kontor;

use strict;
use warnings;
use Kontor::Model;

use base 'Mojolicious';

# This method will run once at server start
sub startup {
    my $self = shift;

	# Model
	my $schema = Kontor::Schema->connect('dbi:Pg:dbname=kontor');
	$schema->org_id(1);
	$schema->currency_id(208);
	$self->helper(model => sub { return $schema });

	# Plugins
	$self->plugin('xslate_renderer');

    # Routes
    my $r = $self->routes;

	# General Ledger
    $r->route('/gl')->to('gl#index');
    $r->route('/gl/daybook')->to('gl#daybook');
    $r->route('/gl/daybook/:id')->to('gl#daybook', id => 1);

    # Default route
    $r->route('/:controller/:action/:id')->to('example#welcome', id => 1);
}

1;
