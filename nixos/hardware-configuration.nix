{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  networking = {
    hostId = "4bd4bef1";
    hostName = "potato";
    networkmanager.enable = true;
  };

  boot = {
    extraModulePackages = [ ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd = {
      availableKernelModules = [ "xhci_pci" "thunderbolt" "vmd" "ahci" "nvme" "usbhid" ];
      kernelModules = [ ];
      luks.devices.crypted = {
        header = "/dev/nvme0n1p5";
        device = "/dev/nvme0n1p6";
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
        device = "/dev/disk/by-uuid/994cd5d1-62c2-4150-b3e2-5ebce6a33fcf";
        fsType = "tmpfs";
        options = [ "defaults" "size=4G" "mode=0755" ];
      };
      esp = device: { inherit device; fsType = "vfat"; };
      zfs = dataset: { device = dataset; fsType = "zfs"; };
      forBoot = { neededForBoot = true; };
    in
    {
      "/" = zfs "rpool/root" // forBoot;
      "/nix" = zfs "rpool/nix" // forBoot;
      "/boot" = esp "/dev/nvme0n1p7";
      "/var/cache" = zfs "rpool/cache";
      "/data/system" = zfs "rpool/data/system";
      "data/getpsyched" = zfs "rpool/data/getpsyched";
      "state/system" = zfs "rpool/state/system" // forBoot;
      "state/getpsyched" = zfs "rpool/state/getpsyched";

      "/mnt/poopos" = {
        device = "/dev/nvme0n1p3";
        fsType = "ntfs";
        options = [ "rw" "uid=1000" ];
      };
    };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp44s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}

