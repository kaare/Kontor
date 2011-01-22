package Kontor::Schema::ResultSet::Gl::Journal;

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
	my ( $self, $args ) = @_;
	my $schema = $self->result_source->schema;
use Data::Dumper;
	$args->{accountnr} =~ s/\D*$// or say $@; ## Should be more intelligent to look up account number!
	## And should throw exceptions!
	die $args unless $args->{accountnr} and my $coa = $schema->resultset('Gl::Chartofaccount')->find({account_nr => $args->{accountnr}});

	# vat
	if (!$args->{soa} and my ($vat_rate, $vat_accountnr) = $self->get_coavat($coa)) {
		# my $grid_args = { dim => '{' . $vat_coa->id . '}', currency_id => $args->{currency_id } };
		# my $acctgrid = $schema->resultset('logicShop::DB::Gl::Acctgrid')->find( $grid_args )
			# || $schema->resultset('logicShop::DB::Gl::Acctgrid')->create( $grid_args );
		my $vat_args = {%$args};
		$vat_args->{accountnr} = $vat_accountnr;
		for my $elm (qw/debit credit/) {
			$vat_args->{$elm} *= $vat_rate / 100;
			$args->{$elm} -= $vat_args->{$elm};
		}
		$self->post($vat_args)
	}
print STDERR "Post! ", Dumper $args;

#	$self->post_one($journal_args); ## Orig
	return if $args->{soa};

	## Do the balancing
}

		# # Balances
		# my $periodnr = $journal->accountingdate->truncate( to => 'month' );
		# my $balance = $journal->acctgrid->find_related( 'balances', { periodnr => $periodnr } );
		# if ($balance) {
			# $balance->update({
				# perioddr => $balance->perioddr + $journal->entereddr,
				# periodcr => $balance->periodcr + $journal->enteredcr,
			# });
		# } else {
			# $balance = $schema->resultset('logicShop::DB::Gl::Balances')->create({
				# ag_id    => $journal->ag_id,
				# periodnr => $periodnr,
				# perioddr => $journal->entereddr,
				# periodcr => $journal->enteredcr
			# });
		# }
		# $balance->update;

sub get_coavat {
	my ( $self, $coa ) = @_;
	my $schema = $self->result_source->schema;
	return unless my $acctvat = $coa->accountvat_coas->single;

	my $vat = $acctvat->vat->rate;
	my $accountnr = $acctvat->vat_coa->account_nr;
	return $vat, $accountnr;
}

1;
