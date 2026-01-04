{
  ...
}:
{
  flake.modules.nixos.example-host =
  # Allows --argstr facterReportFile ./new-facter.json for quick bootstrapping
  { facterReportFile ? ./facter.json, ... }: 
  {
    hardware.facter.reportPath = facterReportFile;
  };
}