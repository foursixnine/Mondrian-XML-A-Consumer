use strict;
use warnings;
use 5.010;
use SOAP::Lite;

use XMLA::Request;
use Data::Dumper;
use XMLA::Person;

my $Request = XMLA::Request->new({
    dataSource => 'Provider=Mondrian;DataSource=DatasisCubo;',
    xmlaProvider => 'http://beholder.galaxy.zarate.net.ve:8080/pentaho/Xmla?userid=joe&password=password',
    queryFormat => 'Tabular',
    namespace => 'urn:schemas-microsoft-com:xml-analysis',
    Catalog => 'DatasisVentas',
});
print Dumper($Request->namespace);
print Dumper($Request->discover('xy'));
