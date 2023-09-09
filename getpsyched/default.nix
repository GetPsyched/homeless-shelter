{ config, lib, pkgs, ... }:
{
  imports = [
    ./browser
    ./dev
    ./gui
    ./window-manager

    ./games.nix
    ./impermanence.nix
    ./thunderbird.nix
    ./wine.nix
  ];

  home = {
    username = lib.mkDefault "getpsyched";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "22.11";

    packages = with pkgs; [
      microsoft-edge
      obsidian
      spotify

      (pkgs.python311Packages.callPackage ../packages/nexus.nix { })
    ];

    shellAliases = {
      heroic = "nix shell github:aidalgol/nixpkgs/heroic-white-screen-fix#heroic -c heroic";
    };
  };

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
