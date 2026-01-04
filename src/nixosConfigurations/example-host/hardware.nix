{
  ...
}:
{
  flake.modules.nixos.example-host =
  # Allows --argstr facterReportFile ./new-facter.json for quick bootstrapping
  { ... }: 
  {
    hardware.facter.reportPath = ./facter.json;
  };
}