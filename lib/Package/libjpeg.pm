package Package::libjpeg;

use strict;
use warnings;

use base qw(Package);

our $VERSION = '7';

sub base_url {
	return "http://www.ijg.org/files";
}

sub packagename {
	return "jpeg-$VERSION";
}

sub filename {
	return "jpegsrc.v$VERSION.tar.gz";
}

#http://www.ijg.org/files/jpegsrc.v7.tar.gz

sub is_built {
	my $self = shift @_;
	return -e $self->packagesrcdir() . "/libjpeg.a";
}

sub subpath_for_check {
	my $self = shift @_;
	return "lib/libjpeg.a";
}

sub configure_flags {
	my $self = shift @_;
	return $self->SUPER::configure_flags(@_) . " --disable-dependency-tracking";
}

sub install {

	my $self = shift @_;
	return undef unless ($self->SUPER::install(@_));

	$self->cd_packagesrcdir();
	$self->shell("make install-libLTLIBRARIES");
	$self->shell("make install-includeHEADERS");
}

sub php_extension_configure_flags {

	my $self = shift @_;
	my (%args) = @_;

	return "--with-jpeg-dir=" . $self->config()->prefix();

}

1;