{
  imports = [
    ../../users/getpsyched

    ../common/core
    ./hardware-configuration.nix

    ../common/optional/display-manager.nix
    ../common/optional/nvidia.nix
    ../common/optional/pipewire.nix
    ../common/optional/steam.nix
    ../common/optional/virtualisation.nix
    ../common/optional/warp.nix
    ../common/optional/xserver.nix
    ../common/optional/zram.nix
  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  persist.sysDataDirs = [ "/var/lib/libvirt" ];
  persist.sysDataFiles = [ "/var/lib/prince/license.dat" ];

  # Fix for https://nix-community.github.io/home-manager/index.xhtml#_why_do_i_get_an_error_message_about_literal_ca_desrt_dconf_literal_or_literal_dconf_service_literal
  programs.dconf.enable = true;

  nixpkgs.overlays = [
    (import ../../overlays/i3.nix)
  ];

  system.stateVersion = "22.11";
}
