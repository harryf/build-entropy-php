package Package::idn;

use strict;
use warnings;

use base qw(Package);

our $VERSION = '1.20';

sub base_url {
	return "http://ftp.gnu.org/gnu/libidn/";
}

sub packagename {
	return "libidn-" . $VERSION;
}

sub subpath_for_check {
	return "lib/libidn.dylib";
}


1;
