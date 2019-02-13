#!/usr/bin/perl
#

#
# Copyright(c)		2019	UT-Battelle, LLC
#				All rights reserved
#

# This script requires to be executed with sudo

use strict;
use warnings "all";

use Getopt::Long;

my $help = 0;
my $verbose = 0;
my $etcDir = undef;

GetOptions (
	"help"		=> \$help,
	"verbose"	=> \$verbose,
	"configdir=s"	=> \$etcDir,
);

# We get the topdir of this code, i.e., the top directory of all the sources
# based on the place where this script is
my $topDir = Cwd::abs_path (dirname (__FILE__)) . "/../../";
my $etcDir = "$topDir/etc/" if (!defined ($etcDir));
my $libDir = "$topDir/src/lib";

my $singularity_config_file = "$etcDir/singularity_images.conf";

# Some sanity checks
die "ERROR: $singularity_config_file does not exist" if (! -e $singularity_config_file);

push (@INC, $libDir);

require "Utils/Exec.pm";
require "Utils/Fmt.pm";

my $cmd;

my $verboseCfg = set_verbosity ($verbose);

my $config = load_config ($singularity_config_file);
die "ERROR: Impossible to load configuration from $singularity_config_file" if (!defined ($config));

my %images_config = %$config;
# FIXME: we need to iterate over the blocks.
foreach my $image (keys (%images_config))
{
	my $path_key = $image . "_path";
	my $def_key = $image . "_def";
	die "ERROR: Undefined path for image $image" if (!defined $images_config{$path_key}

	$cmd = "singularity build $singularity_image_path ompi.def";
	Utils::Exec::run_or_die ($verboseCfg, $cmd);
}

