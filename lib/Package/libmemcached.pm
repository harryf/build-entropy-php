package Package::libmemcached;

use strict;
use warnings;

use base qw(Package);

our $VERSION = '0.34';

sub base_url {
	return "http://download.tangent.org/";
}

sub packagename {
	return "libmemcached-$VERSION";
}

sub filename {
	return "libmemcached-$VERSION.tar.gz";
}

#http://download.tangent.org/libmemcached-0.34.tar.gz

sub is_built {
	my $self = shift @_;
	return -e $self->packagesrcdir() . "/libmemcached.a";
}

sub subpath_for_check {
	my $self = shift @_;
	return "lib/libmemcached.a";
}

sub configure_flags {
	my $self = shift @_;
	return $self->SUPER::configure_flags(@_) . " --disable-dependency-tracking";
}

sub install {

	my $self = shift @_;
	return undef unless ($self->SUPER::install(@_));

	$self->cd_packagesrcdir();
	$self->shell("make install");
}

# sub php_extension_configure_flags {
# 
#   my $self = shift @_;
#   my (%args) = @_;
# 
#   return "--with-jpeg-dir=" . $self->config()->prefix();
# 
# }


1;