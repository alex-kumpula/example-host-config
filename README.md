# cleanslate

This module allows you to define services that wipe and create snaphots of specified paths at boot.

Currently, only BTRFS is supported.

This was originally made to be used with Impermanence to wipe and snapshot the root subvolume at boot. However, this can be used in other ways as well.

## Installation
WIP

## Usage
See the [options](./src/modules/cleanslate/options.nix) for usage.

## Try it out
This repository contains a minimal NixOS configuration output called `example-host` that uses this module with Impermanence to achieve a fresh system each boot. This configuration also has a disko configuration.

To bootstrap `example-host` (recommended to do in a VM)



## Notes
Requires `boot.initrd.systemd.enable = true` in order to work, as it defines a systemd initrd service to run at boot.

Recommended that `services.userborn.enable = true` is set. Needed to ensure that new user home directories are properly created.
- See this issue: https://github.com/NixOS/nixpkgs/issues/6481#issuecomment-3381105884
- May be fixed in the future by: https://github.com/NixOS/nixpkgs/pull/223932


## Credits
- workflow (Florian Peter)'s [dotfiles repo](https://github.com/workflow/dotfiles) which heavily influenced the btrfs script and the systemd initrd service.