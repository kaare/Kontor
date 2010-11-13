package Kontor::Gl;

use 5.010;
use strict;
use warnings;
use DateTime;

use base 'Mojolicious::Controller';

sub index {
    my $self = shift;
    $self->render_text('Welcome to the World of Accounting!');
}

sub daybook {
    my $self = shift;
    my $schema = $self->model();
    my $row = $schema->resultset('Gl::Batch')->create({
    	org_id => 4,
		batchnr => 234,
		postingdate => DateTime->now,
    });
    # Render template "example/welcome.html.ep" with message
    $self->render(row => $row);
}

1;
