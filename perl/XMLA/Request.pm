package XMLA::Request;
use strict;
use warnings;
use 5.010;

use Moose;
use namespace::autoclean;
use SOAP::Lite;

for (qw/ dataSource xmlaProvider queryFormat Catalog namespace /){
      has "$_" => ( is => 'rw',
                    isa => 'Str',
                    required => 0,
                  );
    }

has 'service' => (
    is     => 'ro',
    isa    => 'HASH',
    writer => '_set_service',
);

sub BUILD {

    my $self = shift;
    $self->_setup_service();
    return 1;
}

sub discover {

    my ( $self, $request_type ) = @_;

    my $resultado = $self->service->call(
        'Discover',
        SOAP::Data->name('RequestType')->value($request_type),
        SOAP::Data->name('Restrictions')->value(undef),
        SOAP::Data->name('Properties')->value(undef),

    );
    return $resultado;
}

sub _setup_service {

    my $self = shift;
    $self->_set_service( SOAP::Lite->new( proxy => $self->xmlaProvider ) );
    $self->service->autotype(0);
    $self->service->default_ns( $self->namespace );
    return 1;
}

__PACKAGE__->meta->make_immutable;

1;
