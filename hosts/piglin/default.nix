{
  imports = [
    ../../users/getpsyched

    ../common/core
    ./hardware-configuration.nix

    ../common/optional/dconf.nix
    ../common/optional/i3.nix
    ../common/optional/locale.nix
    ../common/optional/networking.nix
    ../common/optional/nvidia.nix
    ../common/optional/pipewire.nix
    ../common/optional/steam.nix
    ../common/optional/virtualisation.nix
    ../common/optional/warp.nix
    ../common/optional/zram.nix
  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  persist.enable = true;
  persist.sysDataDirs = [ "/var/lib/libvirt" ];
  persist.sysDataFiles = [ "/var/lib/prince/license.dat" ];

  time.timeZone = "Asia/Dubai";
  system.stateVersion = "22.11";
}
