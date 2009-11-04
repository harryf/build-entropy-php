package Package::tidy;

use strict;
use warnings;

use base qw(Package);

our $VERSION = '';

sub base_url {
	return "tidy.cvs.sourceforge.net";
}

# cvs -z3 -d:pserver:anonymous@tidy.cvs.sourceforge.net:/cvsroot/tidy co -P tidy
sub cvs_url {
	return "pserver:anonymous\@tidy.cvs.sourceforge.net:/cvsroot/tidy";
}

sub packagename {
	return "tidy";
}

sub filename {
	return "tidy";
}

sub subpath_for_check {
	return "lib/libtidy.dylib";
}

sub download {
	my $self = shift @_;
	$_->download() foreach $self->dependencies();
	return if ($self->is_downloaded());
	$self->cd_srcdir();
	my $url = $self->cvs_url();
	$self->log("cvs checkout $self from " . $url);
	$self->shell('/usr/bin/cvs', "-z3 -d:$url", 'co -P tidy');
}

sub extract {
}

sub patch {
}

sub package_filelist {
	my $self = shift @_;
	return qw(
		lib/libtidy*.a
	);	
}

sub build_preconfigure {
	my $self = shift @_;
	$self->shell({silent => 0}, "/bin/sh build/gnuauto/setup.sh");
}

sub configure_flags {
	my $self = shift @_;
	return $self->SUPER::configure_flags(@_) . " --enable-shared --enable-static --disable-dependency-tracking";
}

sub build_sourcedirs {
	my $self = shift @_;
	return ($self->packagesrcdir());
}

sub build_make {
	my $self = shift @_;
	$self->shell($self->make_command());
}

sub build {
	my $self = shift @_;
	return undef if ($self->is_built());
	# prepare
	$self->unpack();
	$_->install() foreach $self->dependencies();
	$self->log("building");
	$self->cd_packagesrcdir();
	# autoconf
	$self->build_preconfigure();
	# configure
	$self->build_configure();
	# build
	$self->build_make();
	return 1;
}

sub php_extension_configure_flags {
	my $self = shift @_;
	my (%args) = @_;
	my $prefix = $self->install_prefix();
	return "--with-tidy=$prefix";
}

1;
