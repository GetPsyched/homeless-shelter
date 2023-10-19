{ config, lib, pkgs, ... }:
{
  imports = [
    ./browser
    ./dev
    ./gui
    ./window-manager

    ./games.nix
    ./impermanence.nix
    ./libreoffice.nix
    ./thunderbird.nix
    ./wine.nix
  ];

  home = {
    username = lib.mkDefault "getpsyched";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "22.11";

    packages = with pkgs; [
      digikam
      fh
      obsidian
      spotify

      (pkgs.callPackage ../packages/neuron.nix { })
      (pkgs.python311Packages.callPackage ../packages/nexus.nix {
        pyside6-essentials = (pkgs.python311Packages.callPackage ../packages/pyside6-essentials.nix { });
      })
    ];

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

  # Workaround for https://github.com/nix-community/home-manager/issues/2942
  nixpkgs.config.allowUnfreePredicate = (_: true);

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
