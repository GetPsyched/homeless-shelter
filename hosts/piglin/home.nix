{ config, inputs, pkgs, ... }:
{
  imports = [
    ../../modules/home-manager

    ./applications
    ./desktop-environment
    ./development
    ./tools

    ./impermanence-home.nix
  ];

  home = {
    username = "getpsyched";
    homeDirectory = "/home/${config.home.username}";
    stateVersion = "22.11";

    packages = with pkgs; [
      digikam
      fh
      kalker
      nixpkgs-review
      obsidian
      spotify

      # Wine
      bottles
      winePackages.stagingFull
      winetricks

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

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
