#
# Copyright(c)		2019	UT-Battelle, LLC
#				All rights reserved
#

package Utils::Exec;

our @EXPORT_OK = qw(run_cmd
			run_or_die);

sub run_cmd ($$$)
{
	my ($verboseCfg, $cmd) = @_;

	require Utils::Fmt;
	Utils::Fmt::vlogln ($verboseCfg, "Executing: $cmd");
	return system ($cmd);
}

sub run_or_die ($$)
{
	my ($verboseCfg, $cmd) = @_;
	my $rc = run_cmd ($verboseCfg, $cmd);
	die "ERROR: $cmd failed" if ($rc != 0);
}

1;
