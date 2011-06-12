# http://oss.oetiker.ch/rrdtool/pub/libs/libart_lgpl-2.3.17.tar.gz
package Package::libart;

use strict;
use warnings;

use base qw(Package);

our $VERSION = '2.3.17';

sub base_url {
	return "http://oss.oetiker.ch/rrdtool/pub/libs/";
}

sub packagename {
	return "libart_lgpl-$VERSION";
}

sub filename {
	return "libart_lgpl-$VERSION.tar.gz";
}

sub subpath_for_check {
	return "lib/libart_lgpl_2.a";
}

sub configure_flags {
	my $self = shift @_;
	return $self->SUPER::configure_flags(@_) . " --disable-dependency-tracking";
}

1;