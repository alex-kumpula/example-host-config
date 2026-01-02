{ inputs, config, lib, ... }:
{
  flake.modules.nixos.btrfs-impermanence =
    { lib, ... }:
    {
      options = {
        mainDisk = lib.mkOption {
          type = lib.types.str;
          default = "/dev/vda";
          description = "The main disk device.";
        };
      };
    };
}