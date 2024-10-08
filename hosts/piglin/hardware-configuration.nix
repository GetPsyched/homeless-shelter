{
  config,
  hostName,
  inputs,
  lib,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.hardware.nixosModules.common-gpu-intel
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

  fileSystems =
    let
      mkDataSubvol = subvol: {
        device = "/dev/mapper/cryptroot";
        fsType = "btrfs";
        options = [ "subvol=${subvol},compress=zstd,noatime" ];
        neededForBoot = true;
      };
      mkGeneralSubvol = subvol: {
        device = "/dev/nvme0n1p4";
        fsType = "btrfs";
        options = [ "subvol=${subvol},compress=zstd,noatime" ];
        neededForBoot = true;
      };
      mkBindMount = location: {
        device = location;
        fsType = "none";
        options = [ "bind" ];
        noCheck = true;
      };
    in
    {
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
      "/nix" = mkGeneralSubvol "nix";
      "/var/cache" = mkGeneralSubvol "cache";
      "/persist/data" = mkDataSubvol "data";
      "/persist/sysdata" = mkDataSubvol "sysdata";
      "/persist/bigdata" = mkGeneralSubvol "bigdata";
      "/persist/state" = mkDataSubvol "state";
      "/persist/sysstate" = mkDataSubvol "sysstate";
      "/persist/src" = mkDataSubvol "src";
      "/persist/secrets" = mkDataSubvol "secrets";
      "/persist/steam" = mkDataSubvol "steam";
      # FIXME: Permissions were fixed imperatively. Find a better way
      "/home/getpsyched/.steam" = mkBindMount "/persist/steam/.steam";
    };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
