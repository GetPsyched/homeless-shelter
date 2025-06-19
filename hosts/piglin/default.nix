{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix

    ../../config/atlauncher.nix
    ../../config/bluetooth.nix
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
    ../../config/locale.nix
    ../../config/logseq.nix
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
    ../../config/zsh.nix
  ];

  hjem.users.primary.rum.misc.gtk.enable = true;
  hjem.users.primary.rum.misc.gtk.settings.application-prefer-dark-theme = true;

  users.users.primary.packages = with pkgs; [
    feh
    libreoffice
    mgitstatus
    mindmap
    pavucontrol
    peek
    ripgrep
    sqlitebrowser
    tree
    unzip
  ];

  persist.enable = true;
  persist.data.homeDirectories = [
    "backgrounds"
    "dump"
  ];
  persist.state.homeDirectories = [
    "src"
    ".config/mindmap"
    ".railway"
    ".rustup"
  ];

  time.timeZone = "Asia/Kolkata";
}
