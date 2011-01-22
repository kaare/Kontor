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
	my $model = $self->model;
	my $batch = $model->resultset('Gl::Batch')->find_or_create({
		org_id => 1,
		status => 'active'
	});
	my $now = DateTime->now;
	$batch->update({
#		batchnr => $now->ymd, ## Skulle det virkelig være int?
		postingdate => $now,
	});
	my @banks = map {
		{
			coa_id => $_->coa_id,
			acctnr => $_->coa->account_nr,
			acctname => $_->coa->name,
			balance => $_->balance({periodnr => $batch->postingdate->truncate( to => 'month' )}),
		}
	} $model->resultset('Gl::Accountsoa')->search;
	if ($self->req->method eq 'POST') {
		$self->update_daybook($batch);
		if ($self->req->params('post')) {
			$self->finish_daybook($batch, \@banks);
			$batch = $model->resultset('Gl::Batch')->find_or_create({
				org_id => 1,
				status => 'active'
			});
		}
	}
	my $lines = $batch->lines;
	my $diff;
	$diff = shift @{ $lines } if $lines->[0]->{linenr};
	my $params;
	$params->{"difference.$_.value"} = $diff ? $diff->{banks}->[$_]->{debit} : 0.00 for (0..$#banks);
	my $form = Kontor::Form::Gl::Daybook->new;
	$form->process( params => $params );
	$self->render(batch => $batch, banks => \@banks, lines => $lines, form => $form);
}

sub update_daybook {
	my ($self, $batch) = @_;
	my $params = $self->req->params;
	my $data;
	for my $name ($params->param) {
		$name =~ /(\w+)(?:\[(\d+)\](\w+))?(?:\.(\d+)(?:\.\w+)?)?/;

		if ($1 eq 'difference') {
			$data->{$1}[$4] = $params->param($name);
		} else {
			next unless defined $2;

			if (defined $4) {
				$data->{$1}[$2]{$3}[$4] = $params->param($name);
			} else {
				$data->{$1}[$2]{$3} = $params->param($name);
			}
		}
	}
	# We cheat the difference in as a 0eth line
	my $now = DateTime->now;
	my $diffline = {
		debit => $data->{difference},
		accountnr => 4990,
		accountingdate => $now,
		journalnr => 0,
	};
	unshift @{ $data->{line} }, $diffline;
	$batch->update({
#		batchnr => $now->ymd, ## Skulle det virkelig være int?
		postingdate => $now,
	});
	$batch->update_lines($data->{line});
}

sub finish_daybook {
	my ($self, $batch, $soas) = @_;
	$batch->post_it($soas);
}

1;
