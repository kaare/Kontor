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
    my $soas = $model->resultset('Gl::Accountsoa')->search;
	my @banks;
    while (my $soa = $soas->next) {
    	push @banks, {
			acctname => $soa->coa->name,
			balance => $soa->balance,
		}
    }
    my $batch;
    # my $batch = $model->resultset('Gl::Batch')->create({
    	# org_id => 4,
		# batchnr => 234,
		# postingdate => DateTime->now,
    # });
    my $lines = [
		{
			linenr => 1,
			date => '2010-12-24',
			journalnr => 1,
			text => 'test',
			accountnr => 123456,
			amount => 1.25,
			banks => [(0) x @banks]
		}
    ];
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
