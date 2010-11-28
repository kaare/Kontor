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
    my $model = $self->model();
    my $soas = $model->resultset('Gl::Accountsoa')->search;
    while (my $soa = $soas->next) {
    	my $soabal = $soa->balance;
    }
    my $row;
    # my $row = $model->resultset('Gl::Batch')->create({
    	# org_id => 4,
		# batchnr => 234,
		# postingdate => DateTime->now,
    # });
    # Render template "example/welcome.html.ep" with message
    $self->render(row => $row);
}

1;
