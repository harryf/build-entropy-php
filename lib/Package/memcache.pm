package Package::memcache;

use strict;
use warnings;

use base qw(Package::peclbase);

our $VERSION = '3.0.4';

sub init {
	my $self = shift;
	$self->SUPER::init(@_);
	$self->{PACKAGE_NAME} = 'memcache';
	$self->{VERSION} = $VERSION;
}

return 1;