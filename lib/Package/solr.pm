package Package::solr;

use strict;
use warnings;

use base qw(Package::peclbase);

our $VERSION = '0.9.11';

sub init {
    my $self = shift;
    $self->SUPER::init(@_);
    $self->{PACKAGE_NAME} = 'solr';
    $self->{VERSION} = $VERSION;
}

sub packagesrcdir {
    my $self = shift @_;
    return $self->config()->srcdir() . "/" . $self->packagename() . "/"; 
}

return 1;