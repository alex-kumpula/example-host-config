{
  config,
  ...
}:
{
  flake.modules.nixos.example-host = 
  { config, pkgs, ... }: 
  {
    hardware.facter.reportPath = ./facter.json;
  };
}