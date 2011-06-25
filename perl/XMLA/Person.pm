package XMLA::Person;

use Moose;
use namespace::autoclean;

has 'ssn' => (
    is        => 'rw',
    clearer   => 'clear_ssn',
    predicate => 'has_ssn',
);

__PACKAGE__->meta->make_immutable;

1;
