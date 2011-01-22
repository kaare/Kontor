package Kontor::Schema::ResultSet::Gl::Journal;

use 5.010;
use strict;
use warnings;

use base qw/DBIx::Class::ResultSet/;

=head2 posting

Final posting of journals


if the journal's chartofaccount has a corresponding accountvat the following
will happen:

	- The vat rate is looked up
	- The vat account is looked up
	- Vat amount is calculated and a journal is posted
	- Vat amount is removed from the original journal and it is posted

=cut

sub post {
	my ($self, $args) = @_;
	my $schema = $self->result_source->schema;
	$args->{accountnr} =~ s/\D*$// or say $@; ## Should be more intelligent to look up account number!
	## And should throw exceptions!
	die $args unless $args->{accountnr} and my $coa = $schema->resultset('Gl::Chartofaccount')->find({account_nr => $args->{accountnr}});

	# vat
	if (!$args->{soa} and my ($vat_rate, $vat_accountnr) = $self->get_coavat($coa)) {
		my $vat_args = {%$args};
		$vat_args->{accountnr} = $vat_accountnr;
		for my $elm (qw/debit credit/) {
			$vat_args->{$elm} *= $vat_rate / 100;
			$args->{$elm} -= $vat_args->{$elm};
		}
		$self->post($vat_args)
	}
	my $ag = $self->get_ag($args->{accountnr});
	my $journal_args = {
		batch_id => $args->{batch_id},
		ag_id => $ag->id,
		journalnr => $args->{journalnr} // 0, 
		dr_amount => $args->{debit},
		cr_amount => $args->{credit},
		description => $args->{description} || $args->{name},
		accountingdate => $args->{accountingdate},
	};
	my $journal = $self->create($journal_args);
	$self->balancing($journal);
}

sub balancing {
	my ($self, $journal) = @_;
	my $schema = $self->result_source->schema;
	my $periodnr = $journal->accountingdate->truncate( to => 'month' );
	my $balance = $journal->ag->find_or_create_related( 'balances', { periodnr => $periodnr } );
	$balance->update({
		perioddr => $balance->perioddr + $journal->dr_amount,
		periodcr => $balance->periodcr + $journal->cr_amount,
	});
}

sub get_coavat {
	my ( $self, $coa ) = @_;
	my $schema = $self->result_source->schema;
	return unless my $acctvat = $coa->accountvat_coas->single;

	my $vat = $acctvat->vat->rate;
	my $accountnr = $acctvat->vat_coa->account_nr;
	return $vat, $accountnr;
}

sub get_ag {
	my ($self, $accountnr) = @_;
	my $schema = $self->result_source->schema;
	$accountnr =~ s/\D*$// or say $@; ## Should be more intelligent to look up account number!
	die unless $accountnr and my $coa = $schema->resultset('Gl::Chartofaccount')->find({account_nr => $accountnr});

	my $dims = $schema->resultset('Gl::Getdimensions')->dimensions($coa->account_nr);
	my $rowdata = {
		org_id => $schema->org_id,
		dim => {-value => $dims},
		currency_id => $schema->currency_id,
	};
	my $ag = $schema->resultset('Gl::Acctgrid')->find($rowdata);
	$rowdata->{dim} = $dims;
	$ag = $schema->resultset('Gl::Acctgrid')->create($rowdata) unless $ag;
	return $ag;
	# Leave this for future reference (2011-1-8, not more than 3 months)
	# return $ag->find_or_create_related('balances',{periodnr => '2010-12-01'});##
}


1;
