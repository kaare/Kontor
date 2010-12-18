package Kontor::Form::Gl::Daybook;

use HTML::FormHandler::Moose;

extends 'HTML::FormHandler';

has_field 'difference' => ( type => 'Repeatable', );
has_field 'difference.value' => ( type => 'Money', required => 1, label => '');

no HTML::FormHandler::Moose;
__PACKAGE__->meta->make_immutable;

1;