{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix

    ../../config/activity-watch.nix
    ../../config/atlauncher.nix
    ../../config/bash.nix
    ../../config/bluetooth.nix
    ../../config/boot.nix
    ../../config/charachorder.nix
    ../../config/core.nix
    ../../config/dconf.nix
    ../../config/deshaw.nix
    ../../config/direnv.nix
    ../../config/firefox.nix
    ../../config/flameshot.nix
    ../../config/fzf.nix
    ../../config/games.nix
    ../../config/git.nix
    ../../config/helix.nix
    ../../config/home.nix
    ../../config/hoppscotch.nix
    ../../config/i3.nix
    ../../config/keepassxc.nix
    ../../config/kitty.nix
    ../../config/libreoffice.nix
    ../../config/locale.nix
    ../../config/networking.nix
    ../../config/nvidia.nix
    ../../config/pipewire.nix
    ../../config/rofi
    ../../config/steam.nix
    ../../config/thunderbird.nix
    ../../config/tldr.nix
    ../../config/virt-manager.nix
    ../../config/virtualisation.nix
    ../../config/warp.nix
    ../../config/zed.nix
    ../../config/zoxide.nix
    ../../config/zram.nix
  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  home-manager.users.primary.gtk = {
    enable = true;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  users.users.primary.packages = with pkgs; [
    feh
    mgitstatus
    mindmap
    nixpkgs-review
    obsidian
    pavucontrol
    peek
    ripgrep
    sqlitebrowser
    tree
    unzip
  ];

  persist.enable = true;
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
    ".railway"
    ".rustup"
  ];

  allowUnfreePackages = [ "obsidian" ];

  time.timeZone = "Asia/Kolkata";
}
