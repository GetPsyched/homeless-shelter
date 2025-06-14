{ config, ... }:
{
  boot.initrd.availableKernelModules = [
    "ahci"
    "xhci_pci"
    "virtio_pci"
    "virtio_scsi"
    "sd_mod"
    "sr_mod"
  ];
  boot.loader.grub.device = "/dev/sda";

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/fcca0e4b-d3aa-4c85-ac8a-c75b9af5d9e6";
    fsType = "ext4";
  };
  fileSystems.${config.boot.loader.efi.efiSysMountPoint} = {
    device = "/dev/disk/by-uuid/1841a5d2-0f1f-4883-9d54-3cd0ea49ce5e";
    fsType = "ext4";
  };
  fileSystems."/var/lib" = {
    device = "/dev/disk/by-uuid/df27a768-4138-407f-a9c4-9e3e2821fe50";
    fsType = "ext4";
  };

  swapDevices = [ { device = "/dev/disk/by-uuid/a7fb251a-1b8f-4d67-abf0-090a82714377"; } ];
}
