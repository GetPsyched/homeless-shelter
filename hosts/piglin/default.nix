{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix

    ../../system/user.nix
    ../../system/activity-watch.nix
    ../../system/games
    ../../system/i3.nix
    ../../system/virt-manager.nix
    ../../system/zed.nix
    ../../system/hardware.nix
    ../../system/nix.nix
    ../../system/tailscale.nix
    ../../system/dconf.nix
    ../../system/locale.nix
    ../../system/networking.nix
    ../../system/nvidia.nix
    ../../system/pipewire.nix
    ../../system/virtualisation.nix
    ../../system/warp.nix
    ../../system/zram.nix
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
    xdg.dataFile."warp/accepted-tos.txt".text = "yes";
  };

  allowUnfreePackages = [
    "obsidian"
    "spotify"
  ];

  time.timeZone = "Asia/Dubai";
  system.stateVersion = "22.11";
}
