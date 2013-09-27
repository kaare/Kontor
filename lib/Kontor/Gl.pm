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
	# Will we update?
	if ($self->req->method eq 'POST') {
		$self->update_daybook($batch);
		if ($self->req->param('post')) {
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
	push @{ $params->{difference} }, $diff ? $diff->{banks}->[$_]->{debit} : 0.00 for (0..$#banks);
	$self->render(batch => $batch, banks => \@banks, lines => $lines, form => $params);
}

sub update_daybook {
	my ($self, $batch) = @_;
	my $config = $self->config;
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
	my $diff_coa = $config->{accounts}{difference};
	my $now = DateTime->now;
	my $diffline = {
		debit => $data->{difference},
		accountnr => $diff_coa,
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

sub coa_lookup {
	my $self = shift;
	my $params = $self->req->params;
	my $searchcoa = $params->param('term');
	my $searchparams = ($searchcoa =~ /\d+/) ? {account_nr => {'~*' => $searchcoa}} : {name => {'~*' => $searchcoa}};
	$self->render(json => [
		map {join ' ', $_->account_nr, $_->name} $self->model->resultset('Gl::Chartofaccount')->search($searchparams, {order_by => 'account_nr'})
	]);
}

1;
