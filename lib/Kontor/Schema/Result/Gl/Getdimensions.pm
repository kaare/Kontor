package Kontor::Schema::Result::Gl::Getdimensions;
use strict;
use warnings;
use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/Core/);
__PACKAGE__->table( "dummy" );
__PACKAGE__->add_columns(qw/dims/);

__PACKAGE__->result_source_instance->name(\'(SELECT get_dimensions AS dims FROM gl.get_dimensions(?, ?))');

1;
