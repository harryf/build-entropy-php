package Package::pearbase;

use strict;
use warnings;

use base qw(Package::peclbase);

our $VERSION = '1.0';

sub init {
    my $self = shift @_;
    $self->SUPER::init(@_);
    $self->{PACKAGE_NAME} = 'PEAR';
    $self->{VERSION} = $VERSION;
}

sub base_url {
    return "http://pear.php.net/get";
}

sub packagename {
    my $self = shift @_;
    return $self->{PACKAGE_NAME} . "-" . $self->{VERSION};
}

sub filename {
    my $self = shift @_;
    return $self->packagename() . ".tgz";
}

sub install {
    my $self = shift @_;
    return undef if ($self->is_installed());

    $self->unpack();

    my $src = $self->packagesrcdir();
    my $dst = $self->install_prefix() . '/lib/php/' . $self->{PACKAGE_NAME};

    # move package folder to lib/php
    $self->shell({silent => 0}, "cp -R $src/" . $self->{PACKAGE_NAME} . " $dst");
}

sub extension_ini{
}

sub subpath_for_check {
    my $self = shift @_;
    return sprintf("lib/php/%s", lc($self->{PACKAGE_NAME}));
}

1;