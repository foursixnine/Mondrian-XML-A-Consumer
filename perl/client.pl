use strict;
use warnings;
use 5.010;
use SOAP::Lite;

use XMLA::Request;
use Data::Dumper;

my $Request = XMLA::Request->new({
    dataSource => 'Provider=Mondrian;DataSource=DatasisCubo;',
    xmlaProvider => 'http://beholder.galaxy.zarate.net.ve:8080/pentaho/Xmla?userid=joe&password=password',
    queryFormat => 'Tabular',
    namespace => 'urn:schemas-microsoft-com:xml-analysis',
    Catalog => 'DatasisVentas',
});

my $resultado = $Request->discover('DISCOVER_SCHEMA_ROWSETS')->result;
foreach (@{$resultado->{root}->{row}} ){
    print Dumper($_->{SchemaName});
    my $_->{SchemaName} = $Request->discover($_->{SchemaName})->result;
        print Dumper($_->{SchemaName}->{root}) if $_->{SchemaName}->{root};
    }

