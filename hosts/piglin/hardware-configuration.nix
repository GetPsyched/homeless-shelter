{
  config,
  inputs,
  lib,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.nixos-hardware.nixosModules.common-gpu-intel
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "thunderbolt"
        "vmd"
        "ahci"
        "nvme"
        "usb_storage"
        "usbhid"
        "sd_mod"
      ];
      luks.devices.cryptroot = {
        header = "/dev/nvme0n1p2";
        device = "/dev/nvme0n1p3";
        bypassWorkqueues = true;
      };
      systemd.enable = true;
    };

    kernelModules = [ "kvm-intel" ];
  };

  fileSystems = {
    "/" = {
      device = "none";
      fsType = "tmpfs";
      options = [
        "defaults"
        "size=4G"
        "mode=0755"
      ];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/8167-168A";
      fsType = "vfat";
      neededForBoot = true;
    };
    "/nix" = {
      device = "/dev/nvme0n1p4";
      fsType = "btrfs";
      options = [ "subvol=nix,compress=zstd,noatime" ];
      neededForBoot = true;
    };
    "/persist" = {
      device = "/dev/nvme0n1p4";
      fsType = "btrfs";
      options = [ "compress=zstd,noatime" ];
      neededForBoot = true;
    };
  };

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
