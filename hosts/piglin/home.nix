{ config, inputs, pkgs, ... }:
{
  imports = [
    ../../modules/home-manager

    ./applications
    ./desktop-environment
    ./development
    ./tools
  ];

  gtk = {
    enable = true;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  home = {
    username = "getpsyched";
    homeDirectory = "/home/${config.home.username}";
    stateVersion = "22.11";

    packages = with pkgs; [
      digikam
      nixpkgs-review
      obsidian
      spotify

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

    pointerCursor = {
      name = "Banana";
      size = 48;
      package = (pkgs.callPackage ../../packages/banana-cursor.nix { });
      x11.enable = true;
      gtk.enable = true;
    };
  };

  persist.cacheDirs = [ ".cache" ];
  persist.dataDirs = [ "backgrounds" "iso" "obsidian-vault" ];
  persist.stateDirs = [ ".config/obsidian" ".config/spotify" ".local/share/digikam" ];
  persist.stateFiles = [ ".config/digikamrc" ];
  xdg.dataFile."warp/accepted-tos.txt".text = "yes";

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
