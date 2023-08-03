{ pkgs, ... }:
{
  imports = [
    ./browser
    ./dev
    ./gui
    ./window-manager

    ./games.nix
    ./thunderbird.nix
    ./wine.nix
  ];

  home = {
    username = "getpsyched";
    homeDirectory = "/home/getpsyched";
    stateVersion = "22.11";

    packages = with pkgs; [
      spotify
    ];
  };

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
