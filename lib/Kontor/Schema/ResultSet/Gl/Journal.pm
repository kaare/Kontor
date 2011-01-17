package Kontor::Schema::ResultSet::Gl::Getacctnr;

use strict;
use warnings;

use base qw/DBIx::Class::ResultSet/;

=head2 posting

Final posting of journals

The current design is to expect the same data level as batchjournals, i.e. 
there is an ag_id already. Also, there is a direct link to gl.batches.
If posting will be implemented from other sources, e.g. from invoicing, we may
have to rethink this

The current rate for the currency us looked up if the currency of this journal
differs from the shop's. The rate is used to calculate accounteddr, accountedcr
for all of the journals we mention here.

Accounteddr, accountedcr serves in reality only for documentation purposes;
they should be calculatable from entered columns and batch->currency rate but
they are what is accounted to balances.

if soa_id is defined, it points to a set-off account. The full amount of this
journal will also be posted to the set-off account.

if the journal's chartofaccount has a corresponding accountvat the following
will happen:
- The vat rate is looked up
- The vat account is looked up
- Vat amount is calculated and a journal is posted
- Vat amount is removed from the original journal and it is posted

=cut

sub posting {
	my ( $self, $args ) = @_;
	my $schema = $self->result_source->schema;
	# currency
	my $rate = $self->get_rate($schema->shop->currency_id, $args->{currency_id});
	$args->{accounteddr} = $args->{entereddr} * $rate;
	$args->{accountedcr} = $args->{enteredcr} * $rate;
	my $journal_args = $self->fill_arg_hash($args);
	# vat
	if (my ($vat_rate, $vat_coa) = $self->get_coavat($args)) {
		my $grid_args = { dim => '{' . $vat_coa->id . '}', currency_id => $args->{currency_id } };
		my $acctgrid = $schema->resultset('logicShop::DB::Gl::Acctgrid')->find( $grid_args )
			|| $schema->resultset('logicShop::DB::Gl::Acctgrid')->create( $grid_args );
		my $vat_args = $self->fill_arg_hash($args);
		$vat_args->{ag_id} = $acctgrid->id;
		for my $elm (qw/entereddr enteredcr accounteddr accountedcr/) {
			$vat_args->{$elm} *= $vat_rate / 100;
			$journal_args->{$elm} -= $vat_args->{$elm};
		}
		$self->post_one($vat_args)
	}
	$self->post_one($journal_args); ## Orig
	# Set-off acoount
	if ($args->{soa_id}) {
		my $soa_args = $self->fill_arg_hash($args);
		@{ $soa_args }{qw/entereddr enteredcr accounteddr accountedcr/} = @{ $soa_args }{qw/enteredcr entereddr accountedcr accounteddr/} ;
		$self->post_one($args)
	}
}

sub post_one {
	my ( $self, $args ) = @_;
	my $schema = $self->result_source->schema;
	my $journal;
	my $tx = sub {
		# Journals
		my $journal_args = $self->fill_arg_hash($args);
		delete $journal_args->{id};
		$journal = $schema->resultset('logicShop::DB::Gl::Journals')->create($journal_args);
		# Balances
		my $periodnr = $journal->accountingdate->truncate( to => 'month' );
		my $balance = $journal->acctgrid->find_related( 'balances', { periodnr => $periodnr } );
		if ($balance) {
			$balance->update({
				perioddr => $balance->perioddr + $journal->entereddr,
				periodcr => $balance->periodcr + $journal->enteredcr,
			});
		} else {
			$balance = $schema->resultset('logicShop::DB::Gl::Balances')->create({
				ag_id    => $journal->ag_id,
				periodnr => $periodnr,
				perioddr => $journal->entereddr,
				periodcr => $journal->enteredcr
			});
		}
		$balance->update;
	};
	my $res = $schema->txn_do($tx);
	return $journal;
}

sub get_coavat {
	my ( $self, $args ) = @_;
	my $schema = $self->result_source->schema;
	my $acctgrid  = $schema->resultset('logicShop::DB::Gl::Acctgrid')->find( $args->{ag_id} );
	my $coa_id = $acctgrid->dim->[0];   ## Placement of coa in accountstring, should be configure pr shop
	return unless my $acctvat = $schema->resultset('logicShop::DB::Gl::Accountvat')->find( $coa_id );

	my $vat = $acctvat->vat->rate;
	my $vat_coa = $acctvat->vat_coa;
	return $vat, $vat_coa;
}

sub get_rate {
	my ( $self, $shop_cur, $journal_cur ) = @_;
	return 1 if $shop_cur == $journal_cur;

	my $schema = $self->result_source->schema;
	return $schema->resultset('logicShop::DB::Gl::Currencies')->find($journal_cur)->current_rate;
}

1;
