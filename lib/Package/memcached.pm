package Package::memcached;

use strict;
use warnings;

use base qw(Package::peclbase);

our $VERSION = '1.0.0';

sub init {
	my $self = shift;
	$self->SUPER::init(@_);
	$self->{PACKAGE_NAME} = 'memcached';
	$self->{VERSION} = $VERSION;
}

return 1;