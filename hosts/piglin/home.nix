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
      obsidian
      spotify

      # Wine
      bottles
      winePackages.stagingFull
      winetricks

      (pkgs.callPackage ../../packages/neuron.nix { })
      (pkgs.python311Packages.callPackage ../../packages/nexus.nix {
        pyside6-essentials = (pkgs.python311Packages.callPackage ../../packages/pyside6-essentials.nix {
          shiboken6 = inputs.pyside6.legacyPackages.x86_64-linux.python311Packages.shiboken6;
        });
      })
    ];

    pointerCursor = {
      name = "Banana";
      size = 48;
      package = (pkgs.callPackage ../../packages/banana-cursor.nix { });
      x11.enable = true;
      gtk.enable = true;
    };

    shellAliases = {
      nixpkgs = let git = "${pkgs.git}/bin/git"; gh = "${pkgs.gh}/bin/gh"; in ''
        ${gh} repo sync GetPsyched/nixpkgs --source NixOS/nixpkgs --branch master
        ${git} clone --depth 1 https://github.com/GetPsyched/nixpkgs.git
        cd nixpkgs
        ${git} remote set-branches origin '*'
        ${git} fetch -v --depth=1
      '';
    };
  };

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
