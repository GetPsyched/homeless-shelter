{ config, inputs, pkgs, ... }:
{
  imports = [
    ../../modules/home-manager

    ../common/core
    ../common/optional/games.nix
    ../common/optional/i3.nix
    ../common/optional/virt-manager.nix
  ];

  gtk = {
    enable = true;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  home = {
    username = "getpsyched";

    packages = with pkgs; [
      digikam
      nixpkgs-review
      obsidian
      spotify
      sqlitebrowser

      # Wine
      bottles
      winePackages.stagingFull
      winetricks

      (callPackage ../../packages/hoppscotch-bin.nix { })
      (callPackage ../../packages/mgitstatus.nix { })
      (callPackage ../../packages/neuron.nix { })
      (python311Packages.callPackage ../../packages/nexus.nix {
        pyside6-essentials = (python311Packages.callPackage ../../packages/pyside6-essentials.nix { });
      })
    ];
  };

  persist.cacheDirs = [ ".cache" ];
  persist.dataDirs = [ "backgrounds" "iso" "obsidian-vault" ];
  persist.stateDirs = [ ".config/obsidian" ".config/spotify" ".local/share/digikam" ".rustup" ];
  persist.stateFiles = [ ".config/digikamrc" ".railway/config.json" ];
  xdg.dataFile."warp/accepted-tos.txt".text = "yes";
}