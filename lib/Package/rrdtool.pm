# http://oss.oetiker.ch/rrdtool/pub/rrdtool-1.4.3.tar.gz
package Package::rrdtool;

use strict;
use warnings;

use base qw(Package);

our $VERSION = '1.2.23';

sub base_url {
	return "http://oss.oetiker.ch/rrdtool/pub/";
}

sub packagename {
	return "rrdtool-$VERSION";
}

sub filename {
	return "rrdtool-$VERSION.tar.gz";
}

sub subpath_for_check {
	return "lib/librrd.dylib";
}

sub pkg_config {
	my $self = shift @_;
	return "PKG_CONFIG_PATH=" . $self->config()->prefix() . "/lib/pkgconfig:/usr/X11R6/lib/pkgconfig ";
}

sub configure_flags {
	my $self = shift @_;
	return $self->pkg_config(@_) . $self->SUPER::configure_flags(@_) . " --disable-ruby --disable-rrdcgi --disable-lua --disable-tcl --disable-dependency-tracking";
}

1;