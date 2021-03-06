# Main driver script for the PHP build process
#
# Invoke with
#     sudo perl -Ilib build-php.pl
#

use strict;
use warnings;

use Imports;
use Package::php5;
use Package::xdebug;
use Package::uploadprogress;
use Package::memcached;
use Package::xhprof;

my $basedir = qx(pwd);
chomp $basedir;
die "you must run this script in the build-entropy-php directory" unless ($basedir =~ m#/build-entropy-php$#);

check_dotpear();
check_arch();
check_ltdl();

my $config = Config->new(
	cpus                 => 2,
	basedir              => $basedir,
	prefix               => '/usr/local/php5',
	orahome              => "$basedir/install",
	mysql_install_prefix => undef,
	variants             => {
		apache1          => {
			apxs_option  => '--with-apxs',
			suffix       => '',
		},
		apache2          => {
			apxs_option  => '--with-apxs2=/usr/sbin/apxs',
			suffix       => '-apache2',
		},
	},
	version              => '5.3.0',
	release              => 3,
	debug                => 1,
);

my $php = Package::php5->new(config => $config, variant => 'apache2');
$php->install();

my $xdebug = Package::xdebug->new(config => $config, variant => 'apache2');
$xdebug->install();

my $upload = Package::uploadprogress->new(config => $config, variant => 'apache2');
$upload->install();

my $memcached = Package::memcached->new(config => $config, variant => 'apache2');
$memcached->install();

my $xhprof = Package::xhprof->new(config => $config, variant => 'apache2');
$xhprof->install();


# If there is a ~/.pear directory, "make install-pear" will not work properly
sub check_dotpear {
	if (-e "$ENV{HOME}/.pear" || -e "$ENV{HOME}/.pearrc") {
		die "There is a ~/.pear directory and/or ~/.pearrc file, please move it aside temporarily for the build\n";
	}
}

# If Xcode is installed then the mcrypt extension build picks up libltdl,
# which will be missing on target systems without Xcode.
sub check_ltdl {
	if (glob('/usr/lib/libltdl.*')) {
		die "/usr/lib/libltdl.* files are present on this system but will be missing on target systems, please move them aside temporarily for the build:\nsudo mkdir -p /usr/lib/off && sudo mv /usr/lib/libltdl.* /usr/lib/off/\n";
	}
}

# if we don't build on x86_64, the resulting mcrypt extension will
# work on i386 but crash on x86_64
sub check_arch {
	my $x86_64 = `sysctl -n hw.optional.x86_64`; chomp $x86_64;
	unless ($x86_64) {
		die "This build process must be run on an x86_64 architecture system\n";
	}
}

