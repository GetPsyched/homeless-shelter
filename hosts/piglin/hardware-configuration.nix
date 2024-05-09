{ config, hostName, inputs, lib, pkgs, modulesPath, ... }:
{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
      inputs.hardware.nixosModules.common-gpu-intel
    ];

  networking = {
    inherit hostName;
    hostId = "4bd4bef1";
    networkmanager.enable = true;

    useDHCP = lib.mkDefault true;
  };
  persist.sysStateDirs = [ "/etc/NetworkManager" ];

  boot = {
    extraModulePackages = [ ];

    extraModprobeConfig = ''
      options snd slots=snd-hda-intel model=alc295,dell-headset-multi
    '';
    # options snd-hda-intel model=alc295,dell-headset-multi
    # options snd slots=snd-hda-intel

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
        options = [ "subvol=${subvol},compress=zstd,noatime" ];
      };
      btrfsos = subvol: {
        device = "/dev/nvme0n1p4";
        fsType = "btrfs";
        options = [ "subvol=${subvol},compress=zstd,noatime" ];
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
      "/persist/src" = btrfsdata "src" // forBoot;
      "/persist/secrets" = btrfsdata "secrets" // forBoot;
    };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
