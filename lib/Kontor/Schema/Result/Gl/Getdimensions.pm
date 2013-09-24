package Kontor::Schema::Result::Gl::Getdimensions;

use strict;
use warnings;
use base qw/DBIx::Class::Core/;

__PACKAGE__->table_class('DBIx::Class::ResultSource::View');
__PACKAGE__->table( "dummy" );
__PACKAGE__->add_columns(qw/dims/);

__PACKAGE__->result_source_instance->is_virtual(1);

__PACKAGE__->result_source_instance->view_definition(q{
    SELECT get_dimensions AS dims FROM gl.get_dimensions(?, ?)
});

1;
