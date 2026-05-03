{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix

    ../../specialisations/gaming

    ../../config/beeper.nix
    ../../config/bluetooth.nix
    ../../config/charachorder.nix
    ../../config/core.nix
    ../../config/cosmic.nix
    ../../config/dconf.nix
    ../../config/deshaw.nix
    ../../config/direnv.nix
    ../../config/firefox.nix
    ../../config/flameshot.nix
    ../../config/fzf.nix
    ../../config/git.nix
    ../../config/helix.nix
    ../../config/hoppscotch.nix
    ../../config/jetbrains.nix
    ../../config/keepassxc.nix
    ../../config/kitty.nix
    ../../config/locale.nix
    ../../config/logseq.nix
    ../../config/networking.nix
    ../../config/nvidia.nix
    ../../config/pipewire.nix
    ../../config/syncthing.nix
    ../../config/thunderbird.nix
    ../../config/tldr.nix
    ../../config/warp.nix
    ../../config/winboat.nix
    ../../config/zed.nix
    ../../config/zoxide.nix
    ../../config/zram.nix
    ../../config/zsh.nix
  ];

  hjem.users.primary.rum.misc.gtk = {
    enable = true;
    settings.application-prefer-dark-theme = true;
  };

  users.users.primary.packages = with pkgs; [
    bat
    feh
    jq
    libreoffice
    mgitstatus
    pavucontrol
    peek
    ripgrep
    sqlite
    sqlitebrowser
    tree
    unzip
  ];

  services.syncthing.settings.folders = {
    "aegis" = {
      path = "${config.users.users.primary.home}/dump/aegis";
      type = "receiveonly";
      versioning.type = "trashcan";
    };
    "documents" = {
      path = "${config.users.users.primary.home}/dump/documents";
      type = "sendonly";
      versioning = {
        type = "staggered";
        params = {
          cleanInterval = "3600";
          maxAge = "31536000"; # 365d
        };
      };
    };
    "notes" = {
      path = "${config.users.users.primary.home}/logseq";
      type = "sendreceive";
      versioning = {
        type = "staggered";
        params = {
          cleanInterval = "3600";
          maxAge = "31536000"; # 365d
        };
      };
    };
  };

  persist.enable = true;
  persist.data.homeDirectories = [
    "backgrounds"
    "dump"
  ];
  persist.state.homeDirectories = [
    "src"
    ".railway"
    ".rustup"
  ];

  time.timeZone = "Asia/Kolkata";
}
