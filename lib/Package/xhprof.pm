package Package::xhprof;

use strict;
use warnings;

use base qw(Package::peclbase);

our $VERSION = '0.9.2';

sub init {
	my $self = shift;
	$self->SUPER::init(@_);
	$self->{PACKAGE_NAME} = 'xhprof';
	$self->{VERSION} = $VERSION;
}

sub packagesrcdir {
	my $self = shift @_;
	return $self->config()->srcdir() . "/" . $self->packagename() . "/extension"; 
}

return 1;