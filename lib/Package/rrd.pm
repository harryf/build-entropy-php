# http://oss.oetiker.ch/rrdtool/pub/contrib/php_rrdtool.tar.gz
package Package::rrd;

use strict;
use warnings;

use base qw(Package::peclbase);

our $VERSION = '';

sub init {
	my $self = shift;
	$self->SUPER::init(@_);
	$self->{PACKAGE_NAME} = 'rrdtool';
	$self->{VERSION} = $VERSION;
}

sub packagename {
	my ($self) = shift;
	return $self->{PACKAGE_NAME};
}

sub filename {
	my ($self) = shift;
	return "php_" . $self->packagename() . ".tar.gz";
}

sub base_url {
	my $self = shift;
	return "http://oss.oetiker.ch/rrdtool/pub/contrib/";
}

sub cflags {
	my $self = shift @_;
	return "-DHAVE_RRD_12X " . $self->SUPER::cflags(@_);
}

sub shortname {
	my $self = shift @_;
	return $self->{PACKAGE_NAME};
}

sub configure_flags {
	my $self = shift @_;
	return $self->SUPER::configure_flags(@_) . " --with-rrdtool=" . $self->config()->prefix() . " --disable-dependency-tracking";
}

sub extension_ini{
	my ($self, $dst) = @_;
	$self->shell({silent => 0}, "echo ';extension=" . $dst . lc($self->shortname()) . ".so' > /tmp/50-extension-" . $self->shortname() . ".ini");
}

return 1;