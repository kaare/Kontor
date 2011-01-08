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
	$self->update_daybook($batch) if $self->req->method eq 'POST';
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
	my $diffline = {
		'debit' => $data->{difference},
		'accountnr' => 4990,
		'accountingdate' => DateTime->now,
		'journalnr' => '0',
	};
	unshift @{ $data->{line} }, $diffline;
	$batch->update_lines($data->{line});
}

1;
