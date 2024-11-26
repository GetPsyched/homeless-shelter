{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix

    ../../config/activity-watch.nix
    ../../config/bash.nix
    ../../config/bluetooth.nix
    ../../config/boot.nix
    ../../config/charachorder.nix
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
    ../../config/rofi
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
    ];
  };

  persist.enable = true;
  persist.cache.directories = [ "/var/cache" ];
  persist.data.files = [ "/var/lib/prince/license.dat" ];
  persist.data.homeDirectories = [
    "backgrounds"
    "dump"
    "obsidian-vault"
  ];
  persist.state.homeDirectories = [
    "src"
    ".config/mindmap"
    ".config/obsidian"
    ".config/spotify"
    ".railway"
    ".rustup"
  ];

  allowUnfreePackages = [
    "obsidian"
    "spotify"
  ];

  time.timeZone = "Asia/Kolkata";
  system.stateVersion = "22.11";
}
