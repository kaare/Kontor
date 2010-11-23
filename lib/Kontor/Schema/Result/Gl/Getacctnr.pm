package Kontor::Schema::Result::Gl::Getacctnr;
use strict;
use warnings;
use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/Core/);
__PACKAGE__->table( "dummy" );
__PACKAGE__->add_columns(qw/acctnr/);

__PACKAGE__->result_source_instance->name(\'(SELECT get_acctnr AS acctnr FROM gl.get_acctnr(?, ?))');

1;
