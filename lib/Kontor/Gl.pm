package Kontor::Gl;

use 5.010;
use strict;
use warnings;
use DateTime;

use Kontor::Form::Gl::Daybook;

use base 'Mojolicious::Controller';

sub index {
	my $self = shift;
	$self->render_text('Welcome to the World of Accounting!');
}

sub daybook {
	my $self = shift;
	my $model = $self->model();
	my @banks = map {
		{
			acctname => $_->coa->name,
			balance => $_->balance,
		}
	} $model->resultset('Gl::Accountsoa')->search;
	my $batch = $model->resultset('Gl::Batch')->find_or_create({
		org_id => 1,
		batchnr => 1,
		postingdate => DateTime->now,
	});
	my $lines = $batch->lines;
	my $form = Kontor::Form::Gl::Daybook->new;
	my $params = {
		'difference.0.value' => 1.50,
		'difference.2.value' => 2.50,
		'difference.3.value' => 3.50,
	};
	$form->process( params => $params );
	$self->render(batch => $batch, banks => \@banks, lines => $lines, form => $form);
}

1;
