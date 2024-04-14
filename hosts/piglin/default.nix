{ inputs, lib, config, ... }:
{
  imports = [
    ../../system

    ../common/core
    ./hardware-configuration.nix

    ../common/optional/pipewire.nix
    ../common/optional/steam.nix
  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  users.mutableUsers = false;
  users.users.getpsyched = {
    isNormalUser = true;
    description = "Priyanshu Tripathi";
    extraGroups = [
      "dialout"
      "networkmanager"
      "wheel"
    ];
    hashedPassword = "$y$j9T$KIZivxYTTPjQKqXxXhGRR/$ATU7co5bqgYl2rzHk9xPf5sgflqhGykTEClGx2jAiM2";
  };

  home-manager.users.getpsyched = import ../../users/getpsyched/home.nix;

  persist.sysDataDirs = [ "/var/lib/libvirt" ];
  persist.sysDataFiles = [ "/var/lib/prince/license.dat" ];

  allowUnfreePackages = [
    # Home Manager packages
    "obsidian"
    "osu-lazer-bin-2024.219.0"
    "spotify"
  ];

  # Fix for https://nix-community.github.io/home-manager/index.xhtml#_why_do_i_get_an_error_message_about_literal_ca_desrt_dconf_literal_or_literal_dconf_service_literal
  programs.dconf.enable = true;

  nixpkgs = {
    # TODO: Remove this on next update
    config.permittedInsecurePackages = [ "electron-25.9.0" ];
    overlays = [
      (import ../../overlays/i3.nix)
    ];
  };

  system.stateVersion = "22.11";
}
