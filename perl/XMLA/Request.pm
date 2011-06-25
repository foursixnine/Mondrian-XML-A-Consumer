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
        isa => 'Soap::Lite',
    );

sub BUILD {
    my $self = shift;

    $self->service = SOAP::Lite->proxy($self->xmlaProvider);
    $self->service->autotype(0);
    $self->service->default_ns($self->namespace);

    }

sub discover {

 my ($self, $RequestType) = @_;

 my $resultado = $self->service->call('Discover',
                SOAP::Data->name('RequestType')->value( $_ ),
                SOAP::Data->name('Restrictions')->value( '' ),
                SOAP::Data->name('Properties')->value( '' ),

            );
    return $resultado;
}

__PACKAGE__->meta->make_immutable;

1;
