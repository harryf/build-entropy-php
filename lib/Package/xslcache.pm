package Package::xslcache;

use strict;
use warnings;

use base qw(Package::peclbase);

our $VERSION = '0.7.1';

sub init {
	my $self = shift;
	$self->SUPER::init(@_);
	$self->{PACKAGE_NAME} = 'xslcache';
	$self->{VERSION} = $VERSION;
}

sub extension_ini{
	my ($self, $dst) = @_;
	$self->shell({silent => 0}, "echo ';extension=" . $dst . lc($self->shortname()) . ".so' > /tmp/50-extension-" . $self->shortname() . ".ini");
}

sub configure_flags {
	my $self = shift @_;
	my (%args) = @_;
	return "--with-xslcache=shared," . $self->config()->prefix();
}

return 1;