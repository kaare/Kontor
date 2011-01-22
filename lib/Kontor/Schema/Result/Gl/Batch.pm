package Kontor::Schema::Result::Gl::Batch;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Kontor::Schema::Result::Gl::Batch

=cut

__PACKAGE__->table("gl.batches");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'gl.batches_id_seq'

=head2 org_id

  data_type: 'integer'
  is_nullable: 0

=head2 currency_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 system

  data_type: 'gl.systemtype'
  is_nullable: 1
  size: 4

=head2 batchnr

  data_type: 'integer'
  is_nullable: 1

=head2 name

  data_type: 'text'
  is_nullable: 1

=head2 status

  data_type: 'gl.batchstates'
  is_nullable: 1
  size: 4

=head2 totaldr

  data_type: 'numeric'
  default_value: 0
  is_nullable: 1

=head2 totalcr

  data_type: 'numeric'
  default_value: 0
  is_nullable: 1

=head2 postingdate

  data_type: 'date'
  default_value: current_timestamp
  is_nullable: 1
  original: {default_value => \"now()"}

=head2 soa_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 created

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=head2 modified

  data_type: 'timestamp'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "gl.batches_id_seq",
  },
  "org_id",
  { data_type => "integer", is_nullable => 0 },
  "currency_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "system",
  { data_type => "gl.systemtype", is_nullable => 1, size => 4 },
  "batchnr",
  { data_type => "integer", is_nullable => 1 },
  "name",
  { data_type => "text", is_nullable => 1 },
  "status",
  { data_type => "gl.batchstates", is_nullable => 1, size => 4 },
  "totaldr",
  { data_type => "numeric", default_value => 0, is_nullable => 1 },
  "totalcr",
  { data_type => "numeric", default_value => 0, is_nullable => 1 },
  "postingdate",
  {
    data_type     => "date",
    default_value => \"current_timestamp",
    is_nullable   => 1,
    original      => { default_value => \"now()" },
  },
  "soa_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "created",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
  "modified",
  { data_type => "timestamp", is_nullable => 0 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 soa

Type: belongs_to

Related object: L<Kontor::Schema::Result::Gl::Accountsoa>

=cut

__PACKAGE__->belongs_to(
  "soa",
  "Kontor::Schema::Result::Gl::Accountsoa",
  { id => "soa_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 currency

Type: belongs_to

Related object: L<Kontor::Schema::Result::Gl::Currency>

=cut

__PACKAGE__->belongs_to(
  "currency",
  "Kontor::Schema::Result::Gl::Currency",
  { id => "currency_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 batchjournals

Type: has_many

Related object: L<Kontor::Schema::Result::Gl::Batchjournal>

=cut

__PACKAGE__->has_many(
  "batchjournals",
  "Kontor::Schema::Result::Gl::Batchjournal",
  { "foreign.batch_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 journals

Type: has_many

Related object: L<Kontor::Schema::Result::Gl::Journal>

=cut

__PACKAGE__->has_many(
  "journals",
  "Kontor::Schema::Result::Gl::Journal",
  { "foreign.batch_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-10-16 14:50:02
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:OU1MgTHIS95h98GO+qHxjA

use 5.010;

sub lines {
	my ($self) = @_;
	my $schema = $self->result_source->schema;
	my @soas = $schema->resultset('Gl::Accountsoa')->search;
	my $lines = [ map {
		my $line = $_;
		my ($linenr, $i);
		{
			linenr => ++$linenr,
			accountingdate => $line->accountingdate,
			description => $line->description,
			accountnr => $schema->resultset('Gl::Getacctnr')->acctnr($line->ag->dim), ##
			banks => [
				map {
					my ($debit, $credit);
					if ((my $amount = $line->amount->[$i++]) >= 0) {
						$debit = $amount;
						$credit = 0.00;
					} else {
						$debit = 0.00;
						$credit = -$amount;
					};
					{
						debit => $debit,
						credit => $credit,
						name => $_->coa->name,
						accountnr => $_->coa->account_nr,
					}
				} @soas
			]
		}
	} $self->batchjournals ];
	push @$lines, {
		accountingdate => $self->postingdate,
		# journalnr => 1,
		# text => 'test',
		# accountnr => 123456,
		banks => [map {{debit => 0.00, credit => 0.00, name => $_->coa->name }} @soas]
	};
	return $lines;
}

sub update_lines {
	my ($self, $lines) = @_;
	my $schema = $self->result_source->schema;
	$self->delete_related('batchjournals');
	my $linenr;
	for my $line (@{ $lines} ) {
		$line->{accountnr} =~ s/\D*$// or say $@; ## Should be more intelligent to look up account number!
		next unless $line->{accountnr} and my $coa = $schema->resultset('Gl::Chartofaccount')->find({account_nr => $line->{accountnr}});
		my $dims = $schema->resultset('Gl::Getdimensions')->dimensions($coa->account_nr);
		my $ag = $self->get_ag($dims);
		my @amount;
		push @amount, $line->{debit}->[$_] - $line->{credit}->[$_] for 0..@{ $line->{debit} }-1;
		my $linedata = {
			linenr => $linenr++,
			accountingdate => $line->{accountingdate},
			description => $line->{description} || $coa->name,
			ag_id => $ag->id,
			amount => \@amount,
		};
		$self->create_related('batchjournals', $linedata);
	}
}

sub get_ag {
	my ($self, $dims) = @_;
	my $schema = $self->result_source->schema;
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

sub post_it {
	my ($self, $soas) = @_;
	my $schema = $self->result_source->schema;
	# Find data
	my (@journals, %balance);
	for my $line (@{ $self->lines}) {
		while (my $bank = shift @{ $line->{banks} }) {
			next unless $bank->{debit} or $bank->{credit};

			$line->{credit} += $bank->{debit};
			$line->{debit} += $bank->{credit};
			$balance{$bank->{accountnr}}{credit} += $bank->{credit};
			$balance{$bank->{accountnr}}{debit} += $bank->{debit};
			$balance{$bank->{accountnr}}{name} =  $bank->{name};
			$balance{$bank->{accountnr}}{accountingdate} = $line->{accountingdate};
		}
		next unless $line->{debit} or $line->{credit};

		push @journals, $line;
	}
	while (my ($accountnr, $line) = each %balance) {
		$line->{accountnr} = $accountnr;
		push @journals, $line;
	}
	## start transaction
	## Re-get batch w/lock ?
	for my $line (@journals) {
		$line->{batch_id} = $self->id;
		$self->journals->post($line)
	}
	$self->update({
		# debit, credit
		status => 'accounted',
	});
	## end transaction
}

1;
