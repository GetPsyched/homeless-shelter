{ config, pkgs, ... }:
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
    ../../config/hydralauncher.nix
    ../../config/i3.nix
    ../../config/keepassxc.nix
    ../../config/kitty.nix
    ../../config/locale.nix
    ../../config/logseq.nix
    ../../config/networking.nix
    ../../config/nvidia.nix
    ../../config/pipewire.nix
    ../../config/steam.nix
    ../../config/syncthing.nix
    ../../config/thunderbird.nix
    ../../config/tldr.nix
    ../../config/virt-manager.nix
    ../../config/virtualisation.nix
    ../../config/warp.nix
    ../../config/winboat.nix
    ../../config/zed.nix
    ../../config/zoxide.nix
    ../../config/zram.nix
    ../../config/zsh.nix
  ];

  home-manager.users.primary.gtk = {
    enable = true;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
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
      path = "${config.users.users.primary.home}/src/documents";
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
