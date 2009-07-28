package Package::xdebug;

use strict;
use warnings;

use base qw(Package);

our $VERSION = '2.0.5';

sub base_url {
	my $self = shift;
	return "http://xdebug.org/files/";
}

sub packagename {
	return "xdebug-" . $VERSION;
}

sub filename {
	my ($self) = shift;
	return $self->packagename() . ".tgz";
}

sub build_preconfigure {
	my $self = shift @_;
	$self->cd_packagesrcdir();
	$self->shell($self->install_prefix() . '/bin/phpize  3>&1 2>&3 1>>/tmp/build-entropy-php.log');
}

sub configure_flags {
	my $self = shift @_;
	return join " ", (
		$self->SUPER::configure_flags(@_),
		'--enable-xdebug',
		'--with-php-config=' . $self->install_prefix() . '/bin/php-config'
	);
}

sub install {
	my $self = shift @_;

	$self->build();

	my $dst = $self->install_prefix() . '/lib/php/extensions/no-debug-non-zts-20090626/';

	$self->shell("sudo cp modules/xdebug.so $dst");
	$self->shell({silent => 0}, "echo 'zend_extension=" . $dst . $self->shortname() . ".so' > /tmp/50-extension-" . $self->shortname() . ".ini");
	$self->shell("sudo mv /tmp/50-extension-" . $self->shortname() . ".ini " .$self->install_prefix() . "/php.d/")
}

sub subpath_for_check {
	return "lib/php/extensions/no-debug-non-zts-20090626/modules/xdebug.so";
}

1;