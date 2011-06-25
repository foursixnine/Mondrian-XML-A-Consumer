package XMLA::Request;
use strict;
use warnings;
use 5.010;

use Moose;
use namespace::autoclean;
use SOAP::Lite;

map { has "$_" => ( is => 'rw', isa => 'Str' , required => 0, ) } qw/ dataSource xmlaProvider queryFormat Catalog namespace /;

has 'service' => (
        is => 'ro',
        isa => 'HASH',
        writer => '_set_service',
    );

sub BUILD {

    my $self = shift;
    $self->_setup_service();

    }

sub discover {

 my ($self, $RequestType) = @_;

 my $resultado = $self->service->call('Discover',
                SOAP::Data->name('RequestType')->value( $RequestType ),
                SOAP::Data->name('Restrictions')->value(undef),
                SOAP::Data->name('Properties')->value(undef),

            );
    return $resultado;
}

sub _setup_service {

    my $self = shift;
    $self->_set_service(SOAP::Lite->new(proxy => $self->xmlaProvider));
    $self->service->autotype(0);
    $self->service->default_ns($self->namespace);
    return 1;
}

__PACKAGE__->meta->make_immutable;

1;
