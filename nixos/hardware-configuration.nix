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
      tmpfs = {
        device = "none";
        fsType = "tmpfs";
        options = [ "defaults" "size=4G" "mode=0755" ];
      };
      esp = device: { inherit device; fsType = "vfat"; };
      btrfsdata = subvol: {
        device = "/dev/mapper/cryptroot";
        fsType = "btrfs";
        options = [ "subvol=${subvol}" ];
      };
      btrfsos = subvol: {
        device = "/dev/nvme0n1p4";
        fsType = "btrfs";
        options = [ "subvol=${subvol}" ];
      };
      forBoot = { neededForBoot = true; };
    in
    {
      "/" = tmpfs;
      "/nix" = btrfsos "nix" // forBoot;
      "/boot" = esp "/dev/disk/by-uuid/8167-168A" // forBoot;
      "/var/cache" = btrfsos "cache" // forBoot;
      "/persist/data" = btrfsdata "data" // forBoot;
      "/persist/sysdata" = btrfsdata "sysdata" // forBoot;
      "/persist/bigdata" = btrfsos "bigdata" // forBoot;
      "/persist/state" = btrfsdata "state" // forBoot;
      "/persist/sysstate" = btrfsdata "sysstate" // forBoot;
    };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
