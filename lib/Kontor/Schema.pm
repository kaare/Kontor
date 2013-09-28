use utf8;
package Kontor::Schema;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use Moose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Schema';

__PACKAGE__->load_namespaces;


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-09-27 23:49:04
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:TSe50BrNDtcryYmCaj29/Q

=head1 ATTRIBUTES

=head2 org_id

The current organisation

=cut

has 'org_id' => (
       isa => 'Int',
       is => 'rw',
);

=head2 currency_id

The current currency

=cut

has 'currency_id' => (
       isa => 'Int',
       is => 'rw',
);

__PACKAGE__->meta->make_immutable(inline_constructor => 0);
1;
