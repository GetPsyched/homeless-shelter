{ pkgs, ... }:
{
  imports = [
    ../common/core
    ../common/optional/activity-watch.nix
    ../common/optional/games.nix
    ../common/optional/i3.nix
    ../common/optional/virt-manager.nix
    ../common/optional/zed.nix
  ];

  gtk = {
    enable = true;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  home.packages = with pkgs; [
    hoppscotch
    mgitstatus
    nixpkgs-review
    obsidian
    pavucontrol
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
    "iso"
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
}
