{ config, modulesPath, ... }:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [ "nvme" ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/cdb97443-8361-4f5a-a9a8-eb25885b1b4f";
    fsType = "btrfs";
  };

  fileSystems.${config.boot.loader.efi.efiSysMountPoint} = {
    device = "/dev/disk/by-uuid/F323-FA4E";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };
}
