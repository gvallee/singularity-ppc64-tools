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

# FIXME: use separate Perl module for command execution functions.
# FIXME: use separate Perl module for verbosity management.
my $verbose_cfg;

sub run_cmd_or_fail ($$)
{
	my ($cfg, $cmd) = @_;

	print "Executing: $cmd\n";
	my $_rc = system ($cmd);
	die "ERROR: $cmd failed" if ($_rc);
}

# We try to set the address on tap0, if it fails, it means tap0 is not yet ready
my $ifconfig_cmd = "sudo ifconfig tap0 192.168.100.1";
my $rc = system ($ifconfig_cmd);

# Check if the NAT device is already created or not
if ($rc != 0)
{
	# The network interface does not exist yet, we create it

	# Get the username
	my $username = `whoami`;
	chomp ($username);

	# Actually create the network interface
	$cmd = "sudo tunctl -u $username -t tap0";
	run_cmd_or_fail ($verbose_cfg, $cmd);

	# Bring the tap0 interface up
	run_cmd_or_fail ($verbose_cfg, $ifconfig_cmd);
}
