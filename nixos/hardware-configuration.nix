{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  networking = {
    hostId = "4bd4bef1";
    hostName = "potato";
    networkmanager.enable = true;

    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `interfaces.<interface>.useDHCP`.
    useDHCP = lib.mkDefault true;
    # interfaces.enp44s0.useDHCP = lib.mkDefault true;
    # interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;
  };

  boot = {
    extraModulePackages = [ ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd = {
      availableKernelModules = [ "xhci_pci" "thunderbolt" "vmd" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
      kernelModules = [ ];
      luks.devices.crypted = {
        header = "/dev/nvme0n1p6";
        device = "/dev/nvme0n1p5";
        bypassWorkqueues = true;
      };
      systemd.enable = true;
    };

    kernelModules = [ "kvm-intel" ];
    kernelPackages = pkgs.zfs.latestCompatibleLinuxPackages;
    kernelParams = [ "elevator=none" ];
    supportedFilesystems = [ "ntfs" "zfs" ];
    zfs.devNodes = "/dev/mapper/crypted";
  };

  fileSystems =
    let
      tmpfs = {
        device = "none";
        fsType = "tmpfs";
        options = [ "defaults" "size=4G" "mode=0755" ];
      };
      esp = device: { inherit device; fsType = "vfat"; };
      btrfs = subvol: {
        device = "/dev/mapper/crypted";
        fsType = "btrfs";
        options = [ "subvol=${subvol}" ];
      };
      forBoot = { neededForBoot = true; };
    in
    {
      "/" = tmpfs // forBoot;
      "/nix" = btrfs "nix" // forBoot;
      "/boot" = esp "/dev/disk/by-uuid/EB44-F831" // forBoot;
      "/var/cache" = btrfs "cache" // forBoot;
      "/persist/data/system" = btrfs "data/system" // forBoot;
      "/persist/data" = btrfs "data/getpsyched" // forBoot;
      "/persist/state/system" = btrfs "state/system" // forBoot;
      "/persist/state" = btrfs "state/getpsyched" // forBoot;

      "/mnt/poopos" = {
        device = "/dev/nvme0n1p3";
        fsType = "ntfs";
        options = [ "rw" "uid=1000" ];
      };
    };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
