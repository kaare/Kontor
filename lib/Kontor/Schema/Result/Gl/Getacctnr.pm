package Kontor::Schema::Result::Gl::Getacctnr;

use strict;
use warnings;
use base qw/DBIx::Class::Core/;

__PACKAGE__->table_class('DBIx::Class::ResultSource::View');
__PACKAGE__->table( "dummy" );
__PACKAGE__->add_columns(qw/acctnr/);

__PACKAGE__->result_source_instance->is_virtual(1);

__PACKAGE__->result_source_instance->view_definition(q{
    SELECT get_acctnr AS acctnr FROM gl.get_acctnr(?, ?)
});

1;
