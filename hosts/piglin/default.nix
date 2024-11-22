{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix

    ../../config/activity-watch.nix
    ../../config/bash.nix
    ../../config/bluetooth.nix
    ../../config/boot.nix
    ../../config/dconf.nix
    ../../config/direnv.nix
    ../../config/firefox
    ../../config/flameshot.nix
    ../../config/games.nix
    ../../config/git.nix
    ../../config/helix.nix
    ../../config/i3.nix
    ../../config/kitty.nix
    ../../config/libreoffice.nix
    ../../config/locale.nix
    ../../config/networking.nix
    ../../config/nix.nix
    ../../config/nvidia.nix
    ../../config/pipewire.nix
    ../../config/rofi.nix
    ../../config/steam.nix
    ../../config/ssh.nix
    ../../config/starship.nix
    ../../config/tailscale.nix
    ../../config/thunderbird.nix
    ../../config/tldr.nix
    ../../config/user.nix
    ../../config/virt-manager.nix
    ../../config/virtualisation.nix
    ../../config/warp.nix
    ../../config/zed.nix
    ../../config/zoxide.nix
    ../../config/zram.nix
  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  persist.enable = true;
  persist.sysDataFiles = [ "/var/lib/prince/license.dat" ];

  home-manager.users.${config.mainuser} = {
    gtk = {
      enable = true;
      gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    };

    home.packages = with pkgs; [
      feh
      hoppscotch
      mgitstatus
      nixpkgs-review
      obsidian
      pavucontrol
      peek
      spotify
      sqlitebrowser
      unzip

      (callPackage ../../packages/mindmap.nix { })
      (python311Packages.callPackage ../../packages/nexus.nix {
        pyside6-essentials = (python311Packages.callPackage ../../packages/pyside6-essentials.nix { });
      })
    ];

    persist.enable = true;
    persist.cacheDirs = [ ".cache" ];
    persist.dataDirs = [
      "backgrounds"
      "dump"
      "obsidian-vault"
    ];
    persist.stateDirs = [
      ".config/mindmap"
      ".config/obsidian"
      ".config/spotify"
      ".railway"
      ".rustup"
    ];
  };

  allowUnfreePackages = [
    "obsidian"
    "spotify"
  ];

  time.timeZone = "Asia/Dubai";
  system.stateVersion = "22.11";
}
