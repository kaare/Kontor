package Kontor::Schema::ResultSet::Gl::Getacctnr;

use strict;
use warnings;

use base qw/DBIx::Class::ResultSet/;

sub acctnr {
    my ( $self, $args) = @_;

    $args = '{'.join(',', @$args).'}' if ref $args eq 'ARRAY';
    my $schema = $self->result_source->schema;

    return $self->search( undef, { bind => [ $args, $schema->org_id ] } )->single->acctnr;
}

1;
