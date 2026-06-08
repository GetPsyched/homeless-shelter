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
      luks.devices.encrypted = {
        device = "/dev/disk/by-partlabel/nixos";
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
    ${config.boot.loader.efi.efiSysMountPoint} = {
      device = "/dev/disk/by-partlabel/boot";
      fsType = "vfat";
      neededForBoot = true;
    };
    "/nix" = {
      device = "/dev/mapper/encrypted";
      fsType = "btrfs";
      options = [ "subvol=nix,compress=zstd,noatime" ];
      neededForBoot = true;
    };
    "/persist" = {
      device = "/dev/mapper/encrypted";
      fsType = "btrfs";
      options = [ "subvol=persist,compress=zstd,noatime" ];
      neededForBoot = true;
    };
  };

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
