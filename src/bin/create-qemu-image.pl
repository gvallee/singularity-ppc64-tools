#!/usr/bin/perl
#

#
# Copyright(c)	2019	UT-Battelle, LLC
# 			All rights reserved.
#

use strict;
use warnings "all";

my $image_name = "debian_ppc64.img"; # default image name
my $image_size = 5; # 5G image by default

my $cmd;

# Check if the image file already exists
$cmd = "qemu-img create -f qcow2 ppc64le.img 5G";

# Check whether 'qemu-system-ppc64' is available or not
$cmd = "qemu-system-ppc64";
$rc = run_cmd ($cmd);
if ($rc != 0)
{
	die "ERROR: Cannot find $cmd, please install qemu (>= 3.0.0)";
}

# Check if the ISO to install Debian is already there
my $download_dir = "$topdir/Downloads";
mkdir ($download_dir);

my $iso_path = "$download_dir/$iso_filename";
if (! -e $iso_path)
{
	$cmd = "cd $download_dir; wget $iso_url";
}
else
{
	vprintln ($verbose_cfg, "$iso_path already exists, skipping download");
}

# Bootup a VM so we can install a new Debian system
"qemu-system-ppc64 -machine pseries -cpu power9 -nodefaults -nographic -serial stdio -cdrom /home/gvallee/iso/debian-9.7.0-ppc64el-netinst.iso -hda $image_name"


