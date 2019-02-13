#!/usr/bin/perl
#

#
# Copyright(c)	2019	UT-Battelle, LLC
#			All rights reserved
#

use strict;
use warnings "all";

my $cmd;
my $net_interface = "tap0";

# Check that all the required commands are there
# sudo
# tunctl

# Check if the NAT device is already created or not
$output = `ifconfig $net_interface`;
chomp ($output) if (defined ($output));
if (defined ($output) && $output ne "")
{
	# The network interface does not exist yet, we create it

	# Get the username
	my $username = `whoami`;
	chomp ($username);

	# Actually create the network interface
	$cmd = "sudo tunctl -u $username -t tap0";
	print "$cmd\n";
}


